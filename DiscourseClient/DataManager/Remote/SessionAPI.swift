import Foundation
import UIKit

enum SessionAPIError: Error {
    case emptyData
}

final class SessionAPI {
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session
    }()
    
    func send<T: APIRequest>(request: T, completion: @escaping(Result<T.Response?, Error>) -> ()) {
        let request = request.requestWithBaseUrl()
        
        let task = session.dataTask(with: request) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400, let data = data {
                do {
                    let serverError = try JSONDecoder().decode(DiscourseAPIError.self, from: data)
                    let errorString = serverError.errors?.joined(separator: ", ") ?? "Unknown error"
                    let domainError = NSError(domain: "request", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorString])
                    DispatchQueue.main.async {
                        completion(.failure(domainError))
                    }
                    return
                } catch {
                    let errorDecodingError: NSError = NSError(domain: "request", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error decoding the error"])
                    DispatchQueue.main.async {
                        completion(.failure(errorDecodingError))
                    }
                    return
                }
            }
            
            if let data = data, !data.isEmpty {
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }

            } else {
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
            }
        }
        task.resume()
    }
}

struct DiscourseAPIError: Codable {
    let action: String?
    let errors: [String]?
}

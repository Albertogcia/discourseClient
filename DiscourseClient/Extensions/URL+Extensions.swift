import Foundation

extension URL{
    func getUserImageData(completion: @escaping(Data) -> ()){
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageData: Data = try? Data(contentsOf: self) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}

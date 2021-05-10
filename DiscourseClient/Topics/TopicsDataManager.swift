import Foundation

enum TopicsDataManagerError: Error {
    case unknown
}

protocol TopicsDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
}

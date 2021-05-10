import Foundation

class DiscourseClientDataManager {
    let localDataManager: DiscourseClientLocalDataManager
    let remoteDataManager: DiscourseClientRemoteDataManager

    init(localDataManager: DiscourseClientLocalDataManager, remoteDataManager: DiscourseClientRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}

extension DiscourseClientDataManager: TopicsDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(completion: completion)
    }
}

extension DiscourseClientDataManager: TopicDetailDataManager {
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }
    
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }
}

extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, raw: raw, createdAt: createdAt, completion: completion)
    }
}

extension DiscourseClientDataManager: CategoriesDataManager{
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllCategories(completion: completion)
    }
}

extension DiscourseClientDataManager: UsersDataManager{
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllUsers(completion: completion)
    }
}

extension DiscourseClientDataManager: UserDetailsDataManager{
    func fetchUserDetails(username: String, completion: @escaping (Result<UserDetailsResponse?, Error>) -> ()) {
        remoteDataManager.fetchUserDetails(username: username, completion: completion)
    }
    
    func updateUserName(username: String, newName: String, completion: @escaping (Result<UserNameUpdateResponse?, Error>) -> ()) {
        remoteDataManager.updateUserName(username: username, newName: newName, completion: completion)
    }
}


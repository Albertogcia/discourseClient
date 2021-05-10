import Foundation

protocol DiscourseClientRemoteDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ())
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ())
    
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ())
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
    
    func fetchUserDetails(username: String,  completion: @escaping (Result<UserDetailsResponse?, Error>) -> ())
    func updateUserName(username: String, newName: String,  completion: @escaping (Result<UserNameUpdateResponse?, Error>) -> ())
}

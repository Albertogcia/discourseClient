import Foundation

protocol UsersDataManager{
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
}

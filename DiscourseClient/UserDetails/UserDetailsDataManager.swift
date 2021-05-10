import Foundation

protocol UserDetailsDataManager: class{
    
    func fetchUserDetails(username: String, completion: @escaping (Result<UserDetailsResponse?, Error>) -> ())
    
    func updateUserName(username: String, newName: String,  completion: @escaping (Result<UserNameUpdateResponse?, Error>) -> ())
    
}

import Foundation
struct SingleTopicResponse: Codable {
    let id: Int?
    let title: String?
    let postsCount: Int?
    let details: SingleTopicDetails?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case postsCount = "posts_count"
        case details = "details"
    }
}

struct SingleTopicDetails: Codable{
    let canDelete: Bool?
    
    enum CodingKeys: String, CodingKey {
        case canDelete = "can_delete"
    }
}

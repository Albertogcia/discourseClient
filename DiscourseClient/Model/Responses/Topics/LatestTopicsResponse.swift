import Foundation

struct LatestTopicsResponse: Codable {
    let topicList: TopicList?
    var users: [User] = []
    
    enum CodingKeys: String, CodingKey {
        case topicList = "topic_list"
        case users
    }
}

struct TopicList: Codable {
    var topics: [Topic] = []
}

struct Topic: Codable {
    let id: Int?
    let title: String?
    let postsCount: Int?
    let views: Int?
    let createdAt: String?
    let pinned: Bool?
    let excerpt: String?
    var posters: [Poster] = []

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case views
        case createdAt = "created_at"
        case pinned
        case excerpt
        case posters
    }
}

struct Poster: Codable {
    let description: String?
    let userId: Int?

    enum CodingKeys: String, CodingKey {
        case description
        case userId = "user_id"
    }
}

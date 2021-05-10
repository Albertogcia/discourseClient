import Foundation

struct User: Codable {
    let id: Int?
    let username: String?
    let name: String?
    let avatarTemplate: String?
    let canEditName: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case name = "name"
        case avatarTemplate = "avatar_template"
        case canEditName = "can_edit_name"
    }
}

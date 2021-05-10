import Foundation

struct CategoriesResponse: Codable {
    let categoryList: CategoryList?
    
    enum CodingKeys: String,CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable{
    var categories: [Category] = []
}

struct Category: Codable{
    let id: Int?
    let name: String?
}

import Foundation

protocol CategoriesDataManager{
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ())
}

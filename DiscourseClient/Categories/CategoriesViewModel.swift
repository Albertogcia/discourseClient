import Foundation

protocol CategoriesViewDelegate: class {
    func categoriesFetched()
    func errorFetchingCategories()
}

class CategoriesViewModel {
    let categoriesDataManager: CategoriesDataManager
    weak var viewDelegate: CategoriesViewDelegate?
    var categoriesViewModels: [CategoryCellViewModel] = []

    init(categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
    }

    func viewWasLoaded() {
        fetchAllCategories()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return categoriesViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        guard indexPath.row < categoriesViewModels.count else { return nil }
        return categoriesViewModels[indexPath.row]
    }

    private func fetchAllCategories() {
        categoriesDataManager.fetchAllCategories { [weak self] (result) in
            switch result {
            case .success(let categoriesResponse):
                guard let categories = categoriesResponse?.categoryList?.categories else { return }
                self?.categoriesViewModels = categories.map { (category) -> CategoryCellViewModel in
                    CategoryCellViewModel(category: category)
                }
                self?.viewDelegate?.categoriesFetched()
            case .failure(let error):
                self?.viewDelegate?.errorFetchingCategories()
                print(error)
            }
        }
    }
}

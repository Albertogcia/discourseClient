import Foundation

protocol UsersCoordinatorDelegate: class {
    func didSelect(user: User)
}

protocol UsersViewDelegate: class {
    func usersFetched()
    func errorFetchingUsers()
}

class UsersViewModel {
    weak var coordinatorDelegate: UsersCoordinatorDelegate?
    weak var viewDelegate: UsersViewDelegate?
    let usersDataManager: UsersDataManager
    var usersViewModels: [UserCellViewModel] = []

    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }

    func viewWasLoaded() {
        fetchAllUsers()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return usersViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < usersViewModels.count else { return nil }
        return usersViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < usersViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: usersViewModels[indexPath.row].user)
    }

    private func fetchAllUsers() {
        usersDataManager.fetchAllUsers { [weak self] (result) in
            switch result {
            case .success(let usersResult):
                guard let directoryResults = usersResult?.directoryItems else { return }
                self?.usersViewModels = []
                for directoryResult in directoryResults{
                    if let user = directoryResult.user{
                        self?.usersViewModels.append(UserCellViewModel(user: user))
                    }
                }
                self?.viewDelegate?.usersFetched()
            case .failure:
                self?.viewDelegate?.errorFetchingUsers()
            }
        }
    }
    
    func userNameWasUpdated(){
        fetchAllUsers()
    }
}

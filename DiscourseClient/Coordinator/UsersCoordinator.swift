import UIKit

class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDetailsDataManager: UserDetailsDataManager
    
    var usersViewModel: UsersViewModel?
    
    init(presenter: UINavigationController, usersDataManager: UsersDataManager, userDetailsDataManager: UserDetailsDataManager) {
        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailsDataManager = userDetailsDataManager
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        self.usersViewModel = usersViewModel
        presenter.pushViewController(usersViewController, animated: false)
    }

    override func finish() {}
}

extension UsersCoordinator: UsersCoordinatorDelegate{
    func didSelect(user: User) {
        guard let username = user.username else { return }
        let userDetailsViewModel = UserDetailsViewModel(username: username, userDetailsDataManager: userDetailsDataManager)
        let userDetailsViewController = UserDetailsViewController(viewModel: userDetailsViewModel)
        userDetailsViewModel.viewDelegate = userDetailsViewController
        userDetailsViewModel.coordinatorDelegate = self
        presenter.pushViewController(userDetailsViewController, animated: true)
    }
}

extension UsersCoordinator: UserDetailsCoordinatorDelegate{
    func userDetailsBackButtonTapped() {
        presenter.popViewController(animated: true)
    }
    
    func usernameUpdated() {
        self.usersViewModel?.userNameWasUpdated()
    }
    
    
}

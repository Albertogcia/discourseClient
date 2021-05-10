import Foundation

protocol UserDetailsCoordinatorDelegate: class {
    func userDetailsBackButtonTapped()
    func usernameUpdated()
}

protocol UserDetailsViewDelegate: class {
    func userDetailsFetched()
    func errorFetchingUserDetails()
    func errorUpdatingUsername()
    func successUpdatingUsername()
}

class UserDetailsViewModel {
    var labelUserIdText: String?
    var usernameText: String?
    var nameText: String?
    var nameLabelStackViewIsHidden: Bool!
    var nameTextFieldStackViewIsHidden: Bool!
    var updateNameButtonIsHidden: Bool!

    weak var viewDelegate: UserDetailsViewDelegate?
    weak var coordinatorDelegate: UserDetailsCoordinatorDelegate?
    let userDetailsDataManager: UserDetailsDataManager
    let username: String

    init(username: String, userDetailsDataManager: UserDetailsDataManager) {
        self.username = username
        self.userDetailsDataManager = userDetailsDataManager
    }

    func viewDidLoad() {
        userDetailsDataManager.fetchUserDetails(username: username) { [weak self] (result) in
            switch result {
            case .success(let userDetails):
                guard let userDetails = userDetails, let user = userDetails.user, let self = self else { return }
                self.labelUserIdText = String(user.id ?? 0)
                self.usernameText = user.username
                self.nameText = user.name
                self.nameLabelStackViewIsHidden = user.canEditName ?? false
                self.nameTextFieldStackViewIsHidden = !(user.canEditName ?? false)
                self.updateNameButtonIsHidden = !(user.canEditName ?? false)
                self.viewDelegate?.userDetailsFetched()
            case .failure:
                self?.viewDelegate?.errorFetchingUserDetails()
            }
        }
    }

    func backButtonTapped() {
        coordinatorDelegate?.userDetailsBackButtonTapped()
    }

    func updateButtonTapped(_ newName: String?) {
        guard let newName = newName else { return }
        userDetailsDataManager.updateUserName(username: username, newName: newName) { [weak self] (result) in
            switch result{
            case .success:
                self?.viewDelegate?.successUpdatingUsername()
                self?.coordinatorDelegate?.usernameUpdated()
            case .failure:
                self?.viewDelegate?.errorUpdatingUsername()
            }
        }
    }
}

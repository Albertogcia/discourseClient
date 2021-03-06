import UIKit

class AddTopicCoordinator: Coordinator {
    let presenter: UINavigationController
    let addTopicDataManager: AddTopicDataManager
    var addTopicNavigationController: UINavigationController?
    var onCancelTapped: (() -> Void)?
    var onTopicCreated: (() -> Void)?

    init(presenter: UINavigationController, addTopicDataManager: AddTopicDataManager) {
        self.presenter = presenter
        self.addTopicDataManager = addTopicDataManager
    }

    override func start() {
        let addTopicViewModel = AddTopicViewModel(dataManager: addTopicDataManager)
        addTopicViewModel.coordinatorDelegate = self

        let addTopicViewController = AddTopicViewController(viewModel: addTopicViewModel)
        addTopicViewModel.viewDelegate = addTopicViewController
        addTopicViewController.isModalInPresentation = true
        addTopicViewController.title = "Create"

        let navigationController = UINavigationController(rootViewController: addTopicViewController)
        self.addTopicNavigationController = navigationController
        presenter.present(navigationController, animated: true, completion: nil)
    }

    override func finish() {
        addTopicNavigationController?.dismiss(animated: true, completion: nil)
    }
}

extension AddTopicCoordinator: AddTopicCoordinatorDelegate {
    func addTopicCancelButtonTapped() {
        onCancelTapped?()
    }

    func topicSuccessfullyAdded() {
        onTopicCreated?()
    }
}

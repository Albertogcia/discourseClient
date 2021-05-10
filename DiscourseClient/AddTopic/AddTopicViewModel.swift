import Foundation

protocol AddTopicCoordinatorDelegate: class {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

protocol AddTopicViewDelegate: class {
    func errorAddingTopic()
}

class AddTopicViewModel {
    weak var viewDelegate: AddTopicViewDelegate?
    weak var coordinatorDelegate: AddTopicCoordinatorDelegate?
    let dataManager: AddTopicDataManager

    init(dataManager: AddTopicDataManager) {
        self.dataManager = dataManager
    }

    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }

    func submitButtonTapped(title: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: Date())
        dataManager.addTopic(title: title, raw: title, createdAt: stringDate) { [weak self] (result) in
            switch result {
                case .success:
                    self?.coordinatorDelegate?.topicSuccessfullyAdded()
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.viewDelegate?.errorAddingTopic()
            }
        }
    }
}

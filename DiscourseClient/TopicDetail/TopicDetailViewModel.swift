import Foundation

protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicDeleted()
}

protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopic()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var labelTopicPostNumberText: String?
    var deleteTopicButtonIsHidden: Bool!

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        topicDetailDataManager.fetchTopic(id: topicID) { [weak self] (result) in
            switch result {
            case .success(let topicDetails):
                guard let topicDetails = topicDetails else { return }
                self?.labelTopicIDText = String(topicDetails.id ?? 0)
                self?.labelTopicNameText = topicDetails.title
                self?.labelTopicPostNumberText = String(topicDetails.postsCount ?? 0)
                self?.deleteTopicButtonIsHidden = !(topicDetails.details?.canDelete ?? false)
                self?.viewDelegate?.topicDetailFetched()
            case .failure:
                self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }

    func deleteButtonTapped() {
        topicDetailDataManager.deleteTopic(id: topicID) { [weak self] (result) in
            switch result {
            case .success:
                self?.coordinatorDelegate?.topicDeleted()
            case .failure(let error):
                self?.viewDelegate?.errorDeletingTopic()
                print(error)
            }
        }
    }
}

import Foundation

protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [CellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        fetchAllTopics()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> CellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        let cellViewModel = topicViewModels[indexPath.row]

        if let topicCellViewModel = cellViewModel as? TopicCellViewModel {
            coordinatorDelegate?.didSelect(topic: topicCellViewModel.topic)
        }
        else if let pinnedTopicCellViewModel = cellViewModel as? PinnedTopicCellViewModel {
            coordinatorDelegate?.didSelect(topic: pinnedTopicCellViewModel.topic)
        }
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    private func fetchAllTopics() {
        topicsDataManager.fetchAllTopics { [weak self] (result) in
            switch result {
                case .success(let latestTopicsResponse):
                    guard let latestTopics = latestTopicsResponse?.topicList?.topics, let users = latestTopicsResponse?.users else { return }
                    self?.topicViewModels = latestTopics.map { (topic) -> CellViewModel in
                        if topic.pinned ?? false{
                            return PinnedTopicCellViewModel(topic: topic)
                        }
                        else{
                            var topicUserCreator: User?
                            if !topic.posters.isEmpty, !users.isEmpty {
                                topicUserCreator = users.first(where: { $0.id == topic.posters[0].userId })
                            }
                            return TopicCellViewModel(topic: topic, user: topicUserCreator)
                        }
                    }
                    self?.viewDelegate?.topicsFetched()
                case .failure:
                    self?.viewDelegate?.errorFetchingTopics()
            }
        }
    }

    func newTopicWasCreated() {
        fetchAllTopics()
    }

    func topicWasDeleted() {
        fetchAllTopics()
    }
}

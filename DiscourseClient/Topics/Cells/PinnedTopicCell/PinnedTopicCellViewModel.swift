import Foundation

class PinnedTopicCellViewModel: CellViewModel {
    let topic: Topic
    
    var pinnedTopicTitleText: String?
    var pinnedTopicTextText: String?
    
    init(topic: Topic) {
        self.topic = topic
        
        self.pinnedTopicTitleText = topic.title
        self.pinnedTopicTextText = topic.excerpt
    }
}

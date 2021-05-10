import Foundation


protocol TopicCellViewModelDelegate: class {
    func onImgDownloaded()
}

class TopicCellViewModel: CellViewModel {
    let topic: Topic
    let user: User?
    
    var topicTitleLabelText: String?
    var topicPostCountLabelText: String?
    var topicViewsCountLabelText: String?
    var topicDateLabelText: String?
    var topicUserImageData: Data?
    
    var imageData: Data?
    weak var cellDelegate: TopicCellViewModelDelegate?
    
    init(topic: Topic, user: User?) {
        self.topic = topic
        self.user = user
        
        self.topicTitleLabelText = topic.title
        self.topicPostCountLabelText = String(topic.postsCount ?? 0)
        self.topicViewsCountLabelText = String(topic.views ?? 0)
        self.topicDateLabelText = topic.createdAt?.formatApiDate()
        
        super.init()
        self.getUserImage()
    }
    
    func getUserImage() {
        if imageData != nil {
            cellDelegate?.onImgDownloaded()
        }
        else {
            guard let avatarTemplate = user?.avatarTemplate else { return }
            let imgPath = "https://mdiscourse.keepcoding.io\(avatarTemplate.replacingOccurrences(of: "{size}", with: "100"))"
            guard let imageURL = URL(string: imgPath) else { return }
            imageURL.getUserImageData { [weak self] (imageData) in
                self?.imageData = imageData
                self?.cellDelegate?.onImgDownloaded()
            }
        }
    }
}

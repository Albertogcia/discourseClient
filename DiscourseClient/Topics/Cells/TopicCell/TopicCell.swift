import UIKit

class TopicCell: UITableViewCell {
    
    @IBOutlet var topicUserImageView: UIImageView!
    @IBOutlet var topicTitleLabel: UILabel!
    @IBOutlet var topicPostCountLabel: UILabel!
    @IBOutlet var topicViewsCountLabel: UILabel!
    @IBOutlet var topicDateLabel: UILabel!
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.cellDelegate = self
            
            topicTitleLabel.text = viewModel.topicTitleLabelText
            topicPostCountLabel.text = viewModel.topicPostCountLabelText
            topicViewsCountLabel.text = viewModel.topicViewsCountLabelText
            topicDateLabel.text = viewModel.topicDateLabelText
            
            setUserImage()
        }
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        topicUserImageView.layer.cornerRadius = topicUserImageView.bounds.width / 2
        topicUserImageView.clipsToBounds = true
    }
    
    private func setUserImage() {
        guard let imageData = viewModel?.imageData else {
            topicUserImageView.image = nil
            return
        }
        topicUserImageView.image = UIImage(data: imageData)
    }
}

extension TopicCell: TopicCellViewModelDelegate {
    func onImgDownloaded() {
        setUserImage()
    }
}

import UIKit

class PinnedTopicCell: UITableViewCell {
    
    @IBOutlet weak var pinnedTopicContentView: UIView!
    @IBOutlet weak var pinnedTopicTitleLabel: UILabel!
    @IBOutlet weak var pinnedTopicTextLabel: UILabel!
    
    var viewModel: PinnedTopicCellViewModel? {
        didSet{
            guard let viewModel = viewModel else { return }
            
            pinnedTopicTitleLabel.text = viewModel.pinnedTopicTitleText
            pinnedTopicTextLabel.text = viewModel.pinnedTopicTextText
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pinnedTopicContentView.layer.cornerRadius = 8
        pinnedTopicContentView.clipsToBounds = true
    }
    
}

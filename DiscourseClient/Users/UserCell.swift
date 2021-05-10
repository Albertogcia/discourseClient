import UIKit

class UserCell: UICollectionViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!

    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            viewModel.cellDelegate = self

            userNameLabel.text = viewModel.userNameLabelText

            setUserImage()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
        userImageView.clipsToBounds = true
    }

    private func setUserImage() {
        guard let imageData = viewModel?.imageData else {
            userImageView.image = nil
            return
        }
        userImageView.image = UIImage(data: imageData)
    }
}

extension UserCell: UserCellViewModelDelegate {
    func onImgDownloaded() {
        setUserImage()
    }
}

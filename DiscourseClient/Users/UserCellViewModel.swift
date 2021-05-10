import Foundation

protocol UserCellViewModelDelegate: class {
    func onImgDownloaded()
}

class UserCellViewModel {
    let user: User

    var userNameLabelText: String?

    var imageData: Data?
    weak var cellDelegate: UserCellViewModelDelegate?

    init(user: User) {
        self.user = user
        self.userNameLabelText = user.name
        
        getUserImage()
    }

    func getUserImage() {
        if imageData != nil {
            cellDelegate?.onImgDownloaded()
        }
        else {
            guard let avatarTemplate = user.avatarTemplate else { return }
            let imgPath = "https://mdiscourse.keepcoding.io\(avatarTemplate.replacingOccurrences(of: "{size}", with: "300"))"
            guard let imageURL = URL(string: imgPath) else { return }
            imageURL.getUserImageData { [weak self] (imageData) in
                self?.imageData = imageData
                self?.cellDelegate?.onImgDownloaded()
            }
        }
    }
}

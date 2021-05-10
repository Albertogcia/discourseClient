import UIKit

class UserDetailsViewController: UIViewController {
    
    lazy var labelUserId: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelUsername: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textFieldName: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString("Write here", comment: "")
        return textField
    }()
    
    lazy var updateNameButton: UIButton = {
        let updateNameButton = UIButton()
        updateNameButton.setTitle("Update name", for: .normal)
        updateNameButton.translatesAutoresizingMaskIntoConstraints = false
        updateNameButton.backgroundColor = .blue
        return updateNameButton
    }()
    
    lazy var userIdStackView: UIStackView = {
        let userIdTitle = UILabel()
        userIdTitle.translatesAutoresizingMaskIntoConstraints = false
        userIdTitle.text = NSLocalizedString("User ID: ", comment: "")
        userIdTitle.textColor = .black

        let userIdStackView = UIStackView(arrangedSubviews: [userIdTitle, labelUserId])
        userIdStackView.translatesAutoresizingMaskIntoConstraints = false
        userIdStackView.axis = .horizontal

        return userIdStackView
    }()
    
    lazy var usernameStackView: UIStackView = {
        let usernameTitle = UILabel()
        usernameTitle.translatesAutoresizingMaskIntoConstraints = false
        usernameTitle.text = NSLocalizedString("Username: ", comment: "")
        usernameTitle.textColor = .black

        let usernameStackView = UIStackView(arrangedSubviews: [usernameTitle, labelUsername])
        usernameStackView.translatesAutoresizingMaskIntoConstraints = false
        usernameStackView.axis = .horizontal

        return usernameStackView
    }()
    
    lazy var nameLabelStackView: UIStackView = {
        let nameTitle = UILabel()
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.text = NSLocalizedString("Name: ", comment: "")
        nameTitle.textColor = .black

        let nameStackView = UIStackView(arrangedSubviews: [nameTitle, labelName])
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .horizontal

        return nameStackView
    }()
    
    lazy var nameTextFieldStackView: UIStackView = {
        let nameTitle = UILabel()
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.text = NSLocalizedString("Name: ", comment: "")
        nameTitle.textColor = .black

        let nameStackView = UIStackView(arrangedSubviews: [nameTitle, textFieldName])
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .horizontal

        return nameStackView
    }()
    
    let viewModel: UserDetailsViewModel
    
    init(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(userIdStackView)
        NSLayoutConstraint.activate([
            userIdStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIdStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            userIdStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        view.addSubview(usernameStackView)
        NSLayoutConstraint.activate([
            usernameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            usernameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            usernameStackView.topAnchor.constraint(equalTo: userIdStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(nameLabelStackView)
        NSLayoutConstraint.activate([
            nameLabelStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameLabelStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            nameLabelStackView.topAnchor.constraint(equalTo: usernameStackView.bottomAnchor, constant: 8)
        ])
        nameLabelStackView.isHidden = true
        
        view.addSubview(nameTextFieldStackView)
        NSLayoutConstraint.activate([
            nameTextFieldStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameTextFieldStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            nameTextFieldStackView.topAnchor.constraint(equalTo: usernameStackView.bottomAnchor, constant: 8)
        ])
        nameTextFieldStackView.isHidden = true
        
        view.addSubview(updateNameButton)
        NSLayoutConstraint.activate([
            updateNameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            updateNameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            updateNameButton.topAnchor.constraint(equalTo: nameTextFieldStackView.bottomAnchor, constant: 8)
        ])
        updateNameButton.isHidden = true
        updateNameButton.addTarget(self, action: #selector(updateUsernameTapped), for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        viewModel.viewDidLoad()
    }
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc private func updateUsernameTapped() {
        viewModel.updateButtonTapped(textFieldName.text)
    }
    
    fileprivate func showErrorFetchingUserDetailsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching user details\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showSuccessUpdateUsernameAlert() {
        let alertMessage: String = NSLocalizedString("Username changed successfully", comment: "")
        let alertTitle: String = NSLocalizedString("Success", comment: "")
        showAlert(alertMessage, alertTitle)
    }
    
    fileprivate func showErrorUpdateUsernameAlert() {
        let alertMessage: String = NSLocalizedString("Error updating the username\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func updateUI() {
        labelUserId.text = viewModel.labelUserIdText
        labelUsername.text = viewModel.usernameText
        labelName.text = viewModel.nameText
        textFieldName.text = viewModel.nameText
        //
        nameLabelStackView.isHidden = viewModel.nameLabelStackViewIsHidden
        nameTextFieldStackView.isHidden = viewModel.nameTextFieldStackViewIsHidden
        updateNameButton.isHidden = viewModel.updateNameButtonIsHidden
    }
}

extension UserDetailsViewController: UserDetailsViewDelegate {
    func userDetailsFetched() {
        updateUI()
    }
    
    func errorFetchingUserDetails() {
        showErrorFetchingUserDetailsAlert()
    }
    
    func errorUpdatingUsername() {
        showErrorUpdateUsernameAlert()
    }
    
    func successUpdatingUsername() {
        showSuccessUpdateUsernameAlert()
    }
}

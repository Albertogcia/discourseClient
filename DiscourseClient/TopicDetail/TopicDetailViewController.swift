import UIKit

class TopicDetailViewController: UIViewController {

    lazy var labelTopicID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelTopicPostNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = NSLocalizedString("Topic ID: ", comment: "")
        labelTopicIDTitle.textColor = .black

        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal

        return topicIDStackView
    }()

    lazy var topicNameStackView: UIStackView = {
        let labelTopicTitleTitle = UILabel()
        labelTopicTitleTitle.text = NSLocalizedString("Topic name: ", comment: "")
        labelTopicTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let topicNameStackView = UIStackView(arrangedSubviews: [labelTopicTitleTitle, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal

        return topicNameStackView
    }()

    lazy var topicPostNumberStackView: UIStackView = {
        let labelTopicPostNumberTitle = UILabel()
        labelTopicPostNumberTitle.text = NSLocalizedString("Topic number of posts: ", comment: "")
        labelTopicPostNumberTitle.translatesAutoresizingMaskIntoConstraints = false

        let topicPostNumberStackView = UIStackView(arrangedSubviews: [labelTopicPostNumberTitle, labelTopicPostNumber])
        topicPostNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        topicPostNumberStackView.axis = .horizontal

        return topicPostNumberStackView
    }()

    lazy var deleteTopicButton: UIButton = {
        let deleteTopicButton = UIButton()
        deleteTopicButton.setTitle("Delete topic", for: .normal)
        deleteTopicButton.translatesAutoresizingMaskIntoConstraints = false
        deleteTopicButton.backgroundColor = .blue
        return deleteTopicButton
    }()

    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
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

        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 8)
        ])

        view.addSubview(topicPostNumberStackView)
        NSLayoutConstraint.activate([
            topicPostNumberStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicPostNumberStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            topicPostNumberStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(deleteTopicButton)
        NSLayoutConstraint.activate([
            deleteTopicButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            deleteTopicButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            deleteTopicButton.topAnchor.constraint(equalTo: topicPostNumberStackView.bottomAnchor, constant: 16)
        ])
        deleteTopicButton.isHidden = true
        deleteTopicButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        viewModel.viewDidLoad()
    }

    @objc fileprivate func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc fileprivate func deleteButtonTapped(){
        viewModel.deleteButtonTapped()
    }

    fileprivate func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
    
    fileprivate func showErrorDeletingTopicAlert(){
        let alertMessage: String = NSLocalizedString("Error deleting topic\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI() {
        labelTopicID.text = viewModel.labelTopicIDText
        labelTopicTitle.text = viewModel.labelTopicNameText
        labelTopicPostNumber.text = viewModel.labelTopicPostNumberText
        deleteTopicButton.isHidden = viewModel.deleteTopicButtonIsHidden
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func topicDetailFetched() {
        updateUI()
    }

    func errorFetchingTopicDetail() {
        showErrorFetchingTopicDetailAlert()
    }
    
    func errorDeletingTopic() {
        showErrorDeletingTopicAlert()
    }
}

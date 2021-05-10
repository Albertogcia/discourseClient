import UIKit

class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()

    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()

    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()

    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let tabBarController = UITabBarController()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "lightBackground")
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance

        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()

        let categoriesNavigationController = UINavigationController()
        let categoriesCoordinator = CategoriesCoordinator(presenter: categoriesNavigationController, categoriesDataManager: dataManager)
        addChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.start()
        
        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController, usersDataManager: dataManager, userDetailsDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()

        tabBarController.tabBar.tintColor = .black

        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController, categoriesNavigationController]
        
        tabBarController.tabBar.items?[0].image = UIImage(named: "icon_inicio_unselected")
        tabBarController.tabBar.items?[0].selectedImage = UIImage(named: "icon_inicio_selected")
        tabBarController.tabBar.items?[0].title = NSLocalizedString("Inicio", comment: "")
        
        tabBarController.tabBar.items?[1].image = UIImage(named: "icon_usuarios_unselected")
        tabBarController.tabBar.items?[1].selectedImage = UIImage(named: "icon_usuarios_selected")
        tabBarController.tabBar.items?[1].title = NSLocalizedString("Usuarios", comment: "")
        
        tabBarController.tabBar.items?[2].image = UIImage(systemName: "tag")
    
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    override func finish() {}
}

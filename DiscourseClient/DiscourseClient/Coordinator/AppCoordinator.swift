//
//  AppCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator principal de la app. Encapsula todas las interacciones con la Window.
/// Tiene dos hijos, el topic list, y el categories list (uno por cada tab)
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

        let topicsNavigationController = UINavigationController()
        let fontAttributesNavigation = [NSAttributedString.Key.font : UIFont.largeTitle2Bold1Light1LabelColor1LeftAligned, NSAttributedString.Key.foregroundColor : UIColor.black]
        
        //let bounds = topicsNavigationController.navigationBar.bounds
        //topicsNavigationController.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 140.0)
        
        topicsNavigationController.navigationBar.titleTextAttributes = fontAttributesNavigation
        
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
        usersNavigationController.navigationBar.titleTextAttributes = fontAttributesNavigation
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController, usersDataManager: dataManager, userDetailDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()

        tabBarController.tabBar.backgroundColor = .brownGrey
        //tabBarController.viewControllers = [topicsNavigationController, categoriesNavigationController, usersNavigationController]
        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController]
        
        
        let fontAttributes = [NSAttributedString.Key.font : UIFont.menu, NSAttributedString.Key.foregroundColor : UIColor.brownGrey]
        
        let fontAttributesSelected = [NSAttributedString.Key.foregroundColor : UIColor.tangerine]
        
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributesSelected, for: .selected)
        
        tabBarController.tabBar.items?.first?.image = UIImage(named: "inicioUnselected")
        tabBarController.tabBar.items?.first?.selectedImage = UIImage(named: "inicio")
        
        
        
        tabBarController.tabBar.items?[1].image = UIImage(named: "usuariosUnselected")
        tabBarController.tabBar.items?[1].selectedImage = UIImage(named: "usuarios")
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    override func finish() {}
}

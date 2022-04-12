//
//  TabbarCoordinator.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import UIKit

protocol TabbarCoordinatorProtocol: Coordinator {
    var tabbarController: UITabBarController { get set }
    var currentTab: Int { get }
}

final class TabbarCoordinator: NSObject, TabbarCoordinatorProtocol {
    private var credentialManager: CredentialManager
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabbarController: UITabBarController
    weak var endDelegate: CoordinatorEndDelegate?
    var currentTab: Int {
        return tabbarController.selectedIndex
    }
    
    required init(
        _ navigationController: UINavigationController,
        credentialManager: CredentialManager = CredentialManager.shared
    ) {
        self.navigationController = navigationController
        self.tabbarController = .init()
        self.credentialManager = credentialManager
    }
    
    func start() {
        var views: [TabbarViewController] = [.home, .search, .video]
        
        credentialManager.userName.isNotNil ? views.append(.profile) : views.append(.login)
        
        views = views.sorted(by: { $0.orderNumber < $1.orderNumber })
        
        // Initialization of ViewControllers or these pages
        let viewControllers: [UINavigationController] = views.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: viewControllers)
    }
}

// MARK: - Private Methods

private extension TabbarCoordinator {
    func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabbarController.delegate = self
        tabbarController.setViewControllers(tabControllers, animated: true)
        tabbarController.selectedIndex = TabbarViewController.home.orderNumber
        tabbarController.tabBar.isTranslucent = false
        tabbarController.tabBar.tintColor = UIColor.Core.main
//        tabbarController.tabBar.barTintColor = .brown
        tabbarController.tabBar.backgroundColor = UIColor.Core.tabbar
        
        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
        navigationController.setViewControllers([tabbarController], animated: false)
    }
    
    private func getTabController(_ page: TabbarViewController) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)

        navigationController.tabBarItem = UITabBarItem.init(
            title: page.title,
            image: nil,
            tag: page.orderNumber
        )

        switch page {
        case .home:
            let homeViewController = HomeViewController()
            homeViewController.coordinator = self
            navigationController.pushViewController(homeViewController, animated: true)
            
        case .search:
            let movieSearchViewController = MoviesSearchViewController()
            movieSearchViewController.coordinator = self
            navigationController.pushViewController(movieSearchViewController, animated: true)
            
        case .video:
            let videosViewController = VideoViewController()
            videosViewController.coordinator = self
            navigationController.pushViewController(videosViewController, animated: true)
            
        case .login:
            let registrationnCoordinator = RegistrationCoordinator(navigationController)
            registrationnCoordinator.start()
            registrationnCoordinator.endDelegate = self
            childCoordinators.append(registrationnCoordinator)
            
        case .profile:
            let profileViewController = ProfileViewController()
            navigationController.pushViewController(profileViewController, animated: true)
            break
        }
        
        return navigationController
    }
}

extension TabbarCoordinator: CoordinatorEndDelegate {
    func coordinatorDidEnd(_ childCoordinator: Coordinator) {
        print(childCoordinators.count)
        childCoordinators.removeAll(where: { $0 === childCoordinator })
        print(childCoordinators.count)
        
        switch childCoordinator {
        case is RegistrationCoordinator:
            var views: [TabbarViewController] = [.home, .search, .video, .profile]
                        
            views = views.sorted(by: { $0.orderNumber < $1.orderNumber })
            let viewControllers: [UINavigationController] = views.map({ getTabController($0) })
            tabbarController.setViewControllers(viewControllers, animated: false)
            
            break
            
        default:
            break
        }
    }
}

// MARK: - UITabBarControllerDelegate

extension TabbarCoordinator: UITabBarControllerDelegate {}

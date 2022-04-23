//
//  TabbarCoordinator.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import UIKit

final class TabbarCoordinator: NSObject, TabbarCoordinatorProtocol {
    private var credentialManager: CredentialManager
    private let homeViewController = HomeViewController()
    private let movieSearchViewController = MoviesSearchViewController()
    private let videosViewController = VideosViewController()
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabbarController: UITabBarController
    weak var delegate: CoordinatorDelegate?
    
    var currentTab: Int {
        return tabbarController.selectedIndex
    }
    
    init(
        _ navigationController: UINavigationController,
        credentialManager: CredentialManager = CredentialManager.shared
    ) {
        self.navigationController = navigationController
        self.tabbarController = .init()
        self.credentialManager = credentialManager
    }
    
    func start() {
        setTabbarControllers()
        prepareTabBarController()
    }
}

// MARK: - Private Properties

private extension TabbarCoordinator {
    var isUserLoggedIn: Bool {
        return credentialManager.userName.isNotNil
    }
}

// MARK: - Private Methods

private extension TabbarCoordinator {
    func setTabbarControllers() {
        let views: [TabbarItemView] = [
            .home,
            .search,
            .videos,
            isUserLoggedIn ? .profile : .login
        ].sorted(by: { $0.orderNumber < $1.orderNumber })
        
        let viewControllers: [UINavigationController] = views.map({ getTabController($0) })
        tabbarController.setViewControllers(viewControllers, animated: false)
    }
    
    func prepareTabBarController() {
        tabbarController.delegate = self
        tabbarController.selectedIndex = TabbarItemView.home.orderNumber
        tabbarController.tabBar.isTranslucent = false
        tabbarController.tabBar.tintColor = UIColor.Core.main
//        tabbarController.tabBar.barTintColor = .brown
        tabbarController.tabBar.backgroundColor = UIColor.Core.tabbar
        
        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
        navigationController.setViewControllers([tabbarController], animated: false)
        navigationController.isNavigationBarHidden = true
    }
    
    func getTabController(_ itemView: TabbarItemView) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)

        navigationController.tabBarItem = UITabBarItem.init(
            title: itemView.title,
            image: itemView.iconImage,
            tag: itemView.orderNumber
        )
        setViewController(for: itemView, to: navigationController)
        return navigationController
    }
    
    func setViewController(
        for page: TabbarItemView,
        to navigationController: UINavigationController
    ) {
        switch page {
        case .home:
            homeViewController.coordinator = self
            navigationController.pushViewController(homeViewController, animated: true)
            
        case .search:
            movieSearchViewController.coordinator = self
            navigationController.pushViewController(movieSearchViewController, animated: true)
            
        case .videos:
            videosViewController.coordinator = self
            navigationController.pushViewController(videosViewController, animated: true)
            
        case .login:
            let registrationnCoordinator = RegistrationCoordinator(navigationController)
            registrationnCoordinator.start()
            registrationnCoordinator.delegate = self
            childCoordinators.append(registrationnCoordinator)
            
        case .profile:
            let profileCoordinator = ProfileCoordinator(navigationController)
            profileCoordinator.start()
            profileCoordinator.delegate = self
            childCoordinators.append(profileCoordinator)
            break
        }
    }
}

// MARK: - CoordinatorEndDelegate

extension TabbarCoordinator: CoordinatorDelegate {
    func coordinatorDidEnd(_ childCoordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === childCoordinator })
        
        switch childCoordinator {
        case is RegistrationCoordinator, is ProfileCoordinator:
            setTabbarControllers()
            break
            
        default:
            break
        }
    }
}

// MARK: - UITabBarControllerDelegate

extension TabbarCoordinator: UITabBarControllerDelegate {}

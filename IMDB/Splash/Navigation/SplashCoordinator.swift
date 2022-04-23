//
//  SplashCoordinator.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import UIKit

final class SplashCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var delegate: CoordinatorDelegate?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashViewController = SplashViewController()
        splashViewController.coordinator = self
        navigationController.pushViewController(splashViewController, animated: false)
    }
    
    func presentHomeView() {
        let tabbarCoordinator = TabbarCoordinator(navigationController)
        childCoordinators.append(tabbarCoordinator)
        tabbarCoordinator.start()
    }
}

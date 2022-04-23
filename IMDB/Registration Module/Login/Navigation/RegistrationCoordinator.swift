//
//  RegistrationCoordinator.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import UIKit

final class RegistrationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var delegate: CoordinatorDelegate?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.setViewControllers([loginViewController], animated: false)
    }
}

extension RegistrationCoordinator {
    func presentHomeModule() {
        let homeNavigationController = UINavigationController()
        homeNavigationController.isNavigationBarHidden = true
        let homeCoordinator = TabbarCoordinator(homeNavigationController)
        childCoordinators.append(homeCoordinator)

        homeCoordinator.start()

        homeNavigationController.modalPresentationStyle = .fullScreen
        navigationController.present(homeNavigationController, animated: true, completion: nil)
    }
}

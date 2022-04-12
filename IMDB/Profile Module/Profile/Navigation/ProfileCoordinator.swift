//
//  ProfileCoordinator.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var delegate: CoordinatorDelegate?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileViewController = ProfileViewController()
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
}

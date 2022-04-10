//
//  MainCoordinator.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 30/03/2022.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.viewControllers = [LoginViewController()]
//        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
//        homeCoordinator.start()
    }
}

//
//  MainCoordinator.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 30/03/2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var delegate: CoordinatorDelegate?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabbarCoordinator = TabbarCoordinator(navigationController)
        childCoordinators.append(tabbarCoordinator)
        tabbarCoordinator.start()
    }
}

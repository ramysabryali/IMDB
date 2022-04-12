//
//  Coordinator.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 30/03/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var endDelegate: CoordinatorEndDelegate? { get set }
    
    func start()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        endDelegate?.coordinatorDidEnd(self)
    }
}

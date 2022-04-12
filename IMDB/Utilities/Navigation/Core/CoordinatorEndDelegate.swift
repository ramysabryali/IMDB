//
//  CoordinatorEndDelegate.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import Foundation

protocol CoordinatorEndDelegate: AnyObject {
    func coordinatorDidEnd(_ childCoordinator: Coordinator)
}

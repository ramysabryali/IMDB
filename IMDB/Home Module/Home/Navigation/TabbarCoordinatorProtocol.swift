//
//  TabbarCoordinatorProtocol.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

protocol TabbarCoordinatorProtocol: Coordinator {
    var tabbarController: UITabBarController { get set }
    var currentTab: Int { get }
}

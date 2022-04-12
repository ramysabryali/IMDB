//
//  TabbarItemView.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

enum TabbarItemView {
    case home
    case search
    case videos
    case login
    case profile
}

extension TabbarItemView {
    var title: String {
        switch self {
        case .home:
            return "Home"
            
        case .search:
            return "Search"
            
        case .videos:
            return "Videos"
            
        case .login:
            return "Sign in"
            
        case .profile:
            return "You"
        }
    }
    
    var orderNumber: Int {
        switch self {
        case .home:
            return 0
            
        case .search:
            return 1
            
        case .videos:
            return 2
            
        case .login, .profile:
            return 3
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .home:
            return UIImage.TabBar.home
            
        case .search:
            return UIImage.TabBar.search
            
        case .videos:
            return UIImage.TabBar.videos
            
        case .login, .profile:
            return UIImage.TabBar.user_profile
        }
    }
}

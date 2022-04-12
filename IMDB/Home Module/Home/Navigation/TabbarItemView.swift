//
//  TabbarItemView.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import Foundation

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
            return "Profile"
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
    
    var iconName: String {
        switch self {
        case .home:
            return "Home"
            
        case .search:
            return "Search"
            
        case .videos:
            return "Video"
            
        case .login:
            return "Sign in"
            
        case .profile:
            return "Profile"
        }
    }
}

//
//  TabbarViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import Foundation

enum TabbarViewController {
    case home
    case search
    case video
    case login
    case profile
}

extension TabbarViewController {
    var title: String {
        switch self {
        case .home:
            return "Home"
            
        case .search:
            return "Search"
            
        case .video:
            return "Video"
            
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
            
        case .video:
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
            
        case .video:
            return "Video"
            
        case .login:
            return "Sign in"
            
        case .profile:
            return "Profile"
        }
    }
}

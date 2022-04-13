//
//  ProgressHUDAlertIcon.swift
//  IMDB
//
//  Created by Ramy Sabry on 13/04/2022.
//

import UIKit

public enum ProgressHUDAlertIcon {
    case heart
    case doc
    case bookmark
    case moon
    case star
    case exclamation
    case flag
    case message
    case question
    case bolt
    case shuffle
    case eject
    case card
    case rotate
    case like
    case dislike
    case privacy
    case cart
    case search
}

extension ProgressHUDAlertIcon {
    var image: UIImage? {
        switch self {
        case .heart:
            return "heart.fill".systemNameImage
            
        case .doc:
            return "doc.fill".systemNameImage
            
        case .bookmark:
            return "bookmark.fill".systemNameImage
            
        case .moon:
            return "moon.fill".systemNameImage
            
        case .star:
            return "star.fill".systemNameImage
            
        case .exclamation:
            return "exclamationmark.triangle.fill".systemNameImage
            
        case .flag:
            return "flag.fill".systemNameImage
            
        case .message:
            return "envelope.fill".systemNameImage
            
        case .question:
            return "questionmark.diamond.fill".systemNameImage
            
        case .bolt:
            return "bolt.fill".systemNameImage
            
        case .shuffle:
            return "shuffle".systemNameImage
            
        case .eject:
            return "eject.fill".systemNameImage
            
        case .card:
            return "creditcard.fill".systemNameImage
            
        case .rotate:
            return "rotate.right.fill".systemNameImage
            
        case .like:
            return "hand.thumbsup.fill".systemNameImage
            
        case .dislike:
            return "hand.thumbsdown.fill".systemNameImage
            
        case .privacy:
            return "hand.raised.fill".systemNameImage
            
        case .cart:
            return "cart.fill".systemNameImage
            
        case .search:
            return "magnifyingglass".systemNameImage
        }
    }
}

private extension String {
    var systemNameImage: UIImage? {
        return UIImage(systemName: self)
    }
}

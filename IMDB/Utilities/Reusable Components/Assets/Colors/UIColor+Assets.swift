//
//  UIColor+Assets.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

extension UIColor {
    enum Core {
        static let main = "MainColor".uiColor
        static let tabbar = "TabBarColor".uiColor
    }
}

private extension String {
    var uiColor: UIColor {
        return UIColor(named: self) ?? .clear
    }
}

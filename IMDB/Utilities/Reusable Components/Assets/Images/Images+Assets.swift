//
//  Images+Assets.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

extension UIImage {
    enum TabBar {
        static let home = "tabbar_home".uiImage
        static let search = "tabbar_search".uiImage
        static let videos = "tabbar_videos".uiImage
        static let user_profile = "tabbar_user".uiImage
    }
}

private extension String {
    var uiImage: UIImage {
        return UIImage(named: self) ?? UIImage()
    }
}

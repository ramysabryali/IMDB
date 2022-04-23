//
//  AppConfigurationsManager.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import Foundation

class AppConfigurationsManager: AppConfigurationsProtocol {
    static let shared = AppConfigurationsManager()
    
    private(set) var imagesConfigurations: ImagesConfiguration?
    
    private init() {}
}

extension AppConfigurationsManager {
    var imageBaseUrl: String {
        return (imagesConfigurations?.secureBaseURL).value
    }
}

extension AppConfigurationsManager {
    func set(imagesConfg: ImagesConfiguration) {
        self.imagesConfigurations = imagesConfg
    }
}

//
//  AppConfigurationsProtocol.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import Foundation

protocol AppConfigurationsProtocol {
    var imagesConfigurations: ImagesConfiguration? { get }
    var imageBaseUrl: String { get }
    
    func set(imagesConfg: ImagesConfiguration)
}

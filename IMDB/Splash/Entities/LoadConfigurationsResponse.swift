//
//  LoadConfigurationsResponse.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import Foundation

struct LoadConfigurationsResponse: Decodable {
    let images: ImagesConfiguration?
    let changeKeys: [String]?
    
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}

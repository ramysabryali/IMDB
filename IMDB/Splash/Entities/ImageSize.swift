//
//  ImageSize.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import Foundation

enum ImageSize: String, Decodable {
    case original = "original"
    case w300 = "w300"
    case w780 = "w780"
    case w1280 = "w1280"
    case w45 = "w45"
    case w92 = "w92"
    case w154 = "w154"
    case w185 = "w185"
    case w500 = "w500"
    case w342 = "w342"
    case h632 = "h632"
}

extension ImageSize {
    // Set default value in case of decoding failure
    init(from decoder: Decoder) throws {
        self = try ImageSize(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .original
    }
}

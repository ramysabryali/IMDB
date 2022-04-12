//
//  Data+Helpers.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import Foundation

public extension Data {
    var utfString: String? {
        return String(data: self, encoding: .utf8)
    }
    
    func urlSafeBase64EncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

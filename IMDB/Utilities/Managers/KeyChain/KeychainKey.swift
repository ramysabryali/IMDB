//
//  KeychainKey.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import Foundation

public enum KeychainKey: String, CaseIterable {
    case customerId
    case username
    case password
    
    var value: String {
        return "\(EnvironmentManager.shared.string(key: .productBundle)).\(self.rawValue)"
    }
}

//
//  CredentialsProtocol.swift
//  IMDB
//
//  Created by Ramy Sabry on 24/04/2022.
//

import Foundation

protocol CredentialsProtocol {
    func getValue(for key: KeychainKey) -> String?
    func set(value: String, for key: KeychainKey)
    func delete(service: KeychainKey)
}

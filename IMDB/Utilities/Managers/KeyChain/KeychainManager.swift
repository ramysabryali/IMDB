//
//  KeychainManager.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import Foundation

public final class KeychainManager {
    static let shared = KeychainManager()
    let account: String
    
    private init() {
        self.account = KeychainConstants.account
    }
    
    // MARK: - SAVE
    
    func save(data: String, service: String) throws {
        guard let data = data.data(using: .utf8) else { return }
        let query = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to save in Keychain
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: self.account,
            kSecAttrService: service,
            
            // kSecValueData is the item value to save
            kSecValueData: data
        ] as CFDictionary
        
        // SecItemDelete attempts to perform a delete operation
        // for the item identified by query.
        SecItemDelete(query)
        
        // SecItemAdd attempts to add the item identified by
        // the query to keychain
        let status = SecItemAdd(query, nil)
        
        // Any status other than errSecSuccess indicates the
        // save operation failed.
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func save(data: Data, service: String) throws {
        let query = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to save in Keychain
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: self.account,
            kSecAttrService: service,
            
            // kSecValueData is the item value to save
            kSecValueData: data
        ] as CFDictionary
        
        // SecItemDelete attempts to perform a delete operation
        // for the item identified by query.
        SecItemDelete(query)
        
        // SecItemAdd attempts to add the item identified by
        // the query to keychain
        let status = SecItemAdd(query, nil)
        
        // Any status other than errSecSuccess indicates the
        // save operation failed.
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    // MARK: - UPDATE
    
    func update(data: String, service: String) throws {
        guard let data = data.data(using: .utf8) else { return }
        let query = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to update in Keychain
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: self.account,
            kSecAttrService: service
        ] as CFDictionary
        
        // attributes is passed to SecItemUpdate with
        // kSecValueData as the updated item value
        let attributes = [
            kSecValueData: data
        ] as CFDictionary
        
        // SecItemUpdate attempts to update the item identified
        // by query, overriding the previous value
        let status = SecItemUpdate(query, attributes)
        
        // errSecItemNotFound is a special status indicating the
        // item to update does not exist. Throw itemNotFound so
        // the client can determine whether or not to handle
        // this as an error
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        
        // Any status other than errSecSuccess indicates the
        // update operation failed.
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    // MARK: - DELETE
    
    func delete(service: String) throws {
        let query = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to delete in Keychain
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: self.account,
            kSecAttrService: service
        ] as CFDictionary

        // SecItemDelete attempts to perform a delete operation
        // for the item identified by query. The status indicates
        // if the operation succeeded or failed.
        let status = SecItemDelete(query)

        // Any status other than errSecSuccess indicates the
        // delete operation failed.
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    // MARK: - FETCH
    
    func fetch(service: String) throws -> Data {
        let query = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to read in Keychain
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: self.account,
            kSecAttrService: service,
            
            // kSecMatchLimitOne indicates keychain should read
            // only the most recent item matching this query
            kSecMatchLimit: kSecMatchLimitOne,

            // kSecReturnData is set to Boolean in order
            // to retrieve the data for the item
            kSecReturnData: true
        ] as CFDictionary

        // SecItemCopyMatching will attempt to copy the item
        // identified by query to the reference itemCopy
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(query, &itemCopy)

        // errSecItemNotFound is a special status indicating the
        // read item does not exist. Throw itemNotFound so the
        // client can determine whether or not to handle
        // this case
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        
        // Any status other than errSecSuccess indicates the
        // read operation failed.
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }

        // This implementation of KeychainInterface requires all
        // items to be saved and read as Data. Otherwise,
        // invalidItemFormat is thrown
        guard let data = itemCopy as? Data else {
            throw KeychainError.invalidItemFormat
        }

        return data
    }
}

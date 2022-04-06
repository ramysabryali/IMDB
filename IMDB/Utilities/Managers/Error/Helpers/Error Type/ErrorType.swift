//
//  ErrorType.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import Foundation

enum ErrorType {
    // MARK: - Network
    case connection
    case unwrappedHttpClient
    case unwrappedHttpServer
    
    // MARK: - Backend
    case wrappedHttpClient
    case wrappedHttpServer
    case business
    
    // MARK: - Decoder
    case mapping
    
    // MARK: - Local
    case logical
    case hardware
    case exception
    case permission
    case validation
    
    // MARK: - OTHER
    case unexpected
}

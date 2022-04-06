//
//  ErrorType+Message.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import Foundation

extension ErrorType {
    var message: String {
        switch self {
        case .connection: return "Connection Reason"
        case .unwrappedHttpClient: return "Unwrapped HTTP Client Reason"
        case .unwrappedHttpServer: return "Unwrapped HTTP Server Reason"
        case .wrappedHttpClient: return "Wrapped HTTP Client Reason"
        case .wrappedHttpServer: return "Wrapped HTTP Server Reason"
        case .business: return "Business Reason"
        case .mapping: return "Mapping Reason"
        case .logical: return "Logical Reason"
        case .hardware: return "Hardware Reason"
        case .exception: return "Exception Reason"
        case .permission: return "Permission Reason"
        case .validation: return "Validation Reason"
        case .unexpected: return "Unexpected Reason"
        }
    }
}

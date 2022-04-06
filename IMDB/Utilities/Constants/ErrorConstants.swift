//
//  ErrorConstants.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import Foundation

enum ErrorConstants {
    enum Range {
        static let unwrappedHttpClientRange = 1400...1499
        static let unwrappedHttpServerRange = 1500...1599
        static let wrappedHttpClientRange = 4000...4999
        static let wrappedHttpServerRange = 5000...5999
    }
    
    enum Code {
        static let connectionCode = -1
        static let unwrappedHttpClientCode = 1400
        static let unwrappedHttpServerCode = 1500
        static let wrappedHttpClientCode = 4000
        static let wrappedHttpServerCode = 5000
        static let businessCode = 6000
        static let mappingCode = -1
        static let logicalCode = -1
        static let hardwareCode = -1
        static let exceptionCode = -1
        static let permissionCode = -1
        static let validationCode = -1
        static let unexpectedCode = -1
    }
}

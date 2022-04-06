//
//  BaseError.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import Foundation

struct BaseError: Error {
    let code: Int
    let message: String
}

extension BaseError: Equatable {}

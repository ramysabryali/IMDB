//
//  NSObject+Helpers.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 04/04/2022.
//

import Foundation

extension NSObject {
    /// Returns the receiver's classname as a string, not including the namespace.
    class var classNameWithoutNamespaces: String {
        return String(describing: self)
    }
}

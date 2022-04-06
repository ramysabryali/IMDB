//
//  ViewModelState.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import Foundation

enum ViewModelState<Error> {
    case idle
    case loading
    case successful
    case failed(Error)
}

extension ViewModelState: Equatable {
    static func == (lhs: ViewModelState<Error>, rhs: ViewModelState<Error>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.successful, .successful): return true
            
        case let (.failed(lhsError), .failed(rhsError)):
            guard let lhsError = lhsError as? BaseError, let rhsError = rhsError as? BaseError else {
                return false
            }
            return lhsError == rhsError
            
        default:
            return false
        }
    }
}

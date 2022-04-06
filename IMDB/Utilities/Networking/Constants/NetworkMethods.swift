//
//  APIServiceContract.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 28/03/2022.
//
import Foundation

/// Enumeration that represents types of Network Methods
enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}

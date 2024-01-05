//
//  APICall.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

public protocol APICall {
    /// The path component of the API call URL.
    var path: String { get }
    /// The HTTP method used for the API call.
    var method: HTTPMethod { get }
    /// The headers to be included in the API call.
    var headers: [String: String] { get }
}

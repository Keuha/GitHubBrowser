//
//  HTTPHeaderField.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

/// Enum representing HTTP header fields
public enum HTTPHeaderField: String, CustomStringConvertible, Equatable {
    /// The JSON content type.
    case accept = "Accept"
    
    // version of the API
    case version = "X-GitHub-Api-Version"
    
    // autorization bearer
    case authorization = "Authorization"

    /// A representation of the HTTP header field.
    public var description: String {
        rawValue
    }
}

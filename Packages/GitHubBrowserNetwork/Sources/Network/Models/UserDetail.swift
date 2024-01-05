//
//  UserDetail.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

public struct UserDetail: Identifiable, Codable, Equatable {
    // github user ID
    public let id: Int
    // github user login
    public let login : String
    // number of followers for a user
    public let followers: Int
    // number of following other users
    public let following: Int
}

//
//  User.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

public struct Users: Codable {
    let items: [User]
}

public struct User: Codable, Identifiable, Equatable {
    // github user ID
    public let id: Int
    // github user Login
    public let login: String
    // github user Profile Picture
    public let avatarUrl: String
    // github URL
    public let htmlUrl: URL
    // github followerURL
    public let followersUrl: URL
    // github followingURL
    public let followingUrl: URL
    // github repos URL
    public let reposUrl: URL
}

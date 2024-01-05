//
//  User.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

public struct Users: Codable, Equatable {
    public let items: [User]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decodeIfPresent([User].self, forKey: .items) ?? []
    }
    
    public init(items: [User]) {
        self.items = items
    }
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
    
    public init(
        id: Int,
        login: String,
        avatarUrl: String,
        htmlUrl: URL,
        followersUrl: URL,
        followingUrl: URL,
        reposUrl: URL
    ) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.htmlUrl = htmlUrl
        self.followersUrl = followersUrl
        self.followingUrl = followingUrl
        self.reposUrl = reposUrl
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        self.htmlUrl = try container.decode(URL.self, forKey: .htmlUrl)
        self.followersUrl = try container.decode(URL.self, forKey: .followersUrl)
        self.followingUrl = try container.decode(URL.self, forKey: .followingUrl)
        self.reposUrl = try container.decode(URL.self, forKey: .reposUrl)
    }
}

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
    public let login: String
    // name of the github User
    public let name: String
    // number of followers for a user
    public let followers: Int
    // number of following other users
    public let following: Int
    
    public init(
        id: Int,
        login: String,
        name: String,
        followers: Int,
        following: Int
    ) {
        self.id = id
        self.login = login
        self.name = name
        self.followers = followers
        self.following = following
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.followers = try container.decode(Int.self, forKey: .followers)
        self.following = try container.decode(Int.self, forKey: .following)
    }
}

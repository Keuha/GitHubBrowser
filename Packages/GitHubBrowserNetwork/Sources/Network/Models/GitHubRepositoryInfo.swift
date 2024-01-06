//
//  GitHubRepositoryInfo.swift
//
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

public struct GitHubRepositoryInfo: Codable, Identifiable, Equatable {
    // id of the Github account
    public let id: Int
    // name of the GitHub Account
    public let name: String
    // if the repository is a fork
    public let fork: Bool
    // description of the repository, can be nil
    public let description: String?
    // number of star the repository received
    public let stargazersCount: Int
    // language used in the repository, can be nil
    public let language: String?
    // URL of the repository
    public let htmlUrl: URL
}

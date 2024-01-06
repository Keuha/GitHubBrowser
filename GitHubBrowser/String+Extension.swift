//
//  String+Extension.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 06/01/2024.
//

import Foundation

// swiftlint:disable all
public extension String {
    var translate: String {
        return NSLocalizedString(self, comment: "")
    }
}
// swiftlint:enable all

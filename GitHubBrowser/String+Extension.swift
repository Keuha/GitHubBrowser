//
//  String+Extension.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 06/01/2024.
//

import Foundation

extension String {
    public var translate: String {
        return NSLocalizedString(self, comment: "")
    }
}

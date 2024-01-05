//
//  File.swift
//  
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation

enum Constant {
    enum Transaction {
        static let response = 0.5
        static let dampingFraction = 0.65
        static let blendDuration = 0.025
    }
    
    enum Sizing {
        static let pictureMaxWidth = 60.0
        static let iconMaxWidth = 40.0
    }
    
    enum Radius {
        static let small = 8.0
    }
    
    enum Row {
        static let minHeight = 40.0
        static let maxHeight = 80.0
    }
}

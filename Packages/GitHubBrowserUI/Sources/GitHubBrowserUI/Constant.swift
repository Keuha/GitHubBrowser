//
//  File.swift
//  
//
//  Created by Franck Petriz on 05/01/2024.
//

import Foundation
import SwiftUI

enum Constant {
   
    static let cardBackground = Color(red: 18 / 155, green: 18 / 255, blue: 18 / 255, opacity: 0.3)

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
    
    enum Icons {
        static let size = 12.0
    }
}

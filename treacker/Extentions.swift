//
//  Extentions.swift
//  treacker
//
//  Created by Константин Емельянов on 11.10.2020.
//  Copyright © 2020 Константин Емельянов. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

extension Font {
    
    static let LargeTextFont: Font = system(size: 80, weight: .light)
    
}

extension Color {
    
    static let backLeplasak = Color("Leplasak")
    
    static let shadowLeplasak = Color("ShadowLeplasak")
    
    static let textLeplasak = Color("TextLeplasak")
    
    static let mapButton = Color("MapButtons")
    
}

enum Active {
    case on
    case off
}

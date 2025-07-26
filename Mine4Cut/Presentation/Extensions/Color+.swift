//
//  Color+.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/26/25.
//

import SwiftUI

extension Color {
 
    static let main100 = Color(hex: "B8D2FF")
    static let main200 = Color(hex: "9FC2FF")
    static let main300 = Color(hex: "6A9CFF")
    static let main400 = Color(hex: "3075FF")
    static let main500 = Color(hex: "3B69FF")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

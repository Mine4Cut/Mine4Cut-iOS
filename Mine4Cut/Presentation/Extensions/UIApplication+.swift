//
//  UIApplication+.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import UIKit

extension UIApplication {
    static var screenSize: CGSize {
        guard let windowScene = shared.connectedScenes.first as? UIWindowScene else {
            return UIScreen.main.bounds.size
        }
        return windowScene.screen.bounds.size
    }
    
    static let screenHeight: CGFloat = screenSize.height
    static let screenWidth: CGFloat = screenSize.width
    static let isMinimumSizeDevice: Bool = screenSize.height <= 667
}

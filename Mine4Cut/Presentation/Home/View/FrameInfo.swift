//
//  Frame.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import Foundation

enum FrameSize {
    case small
    case medium
    case large
    
    var widthRatio: CGFloat {
        switch self {
        case .small: return 0.16
        case .medium: return 0.26
        case .large: return 0.43
        }
    }
    
    private var aspectRatio: CGFloat {
        return 1.4
    }
    
    func width(_ screenWidth: CGFloat) -> CGFloat {
        return screenWidth * widthRatio
    }
    
    func height(_ screenWidth: CGFloat) -> CGFloat {
        return width(screenWidth) * aspectRatio
    }
}

// TODO: - property 미정
struct FrameInfo {
    let imageURL: String
    let title: String
    let description: String
    
    init(imageURL: String, title: String, description: String) {
        self.imageURL = imageURL
        self.title = title
        self.description = description
    }
}

extension FrameInfo {
    static let mockFrames: [FrameInfo] = Array(0..<10).map { idx in
        FrameInfo(
            imageURL: "placeholder_\(idx+1)",
            title: "Frame \(idx+1)",
            description: "Description \(idx+1)"
        )
    }
}

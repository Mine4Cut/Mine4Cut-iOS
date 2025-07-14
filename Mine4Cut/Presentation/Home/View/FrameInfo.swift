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
    let creator: String
    let downloads: Int
    let rank: Int?
    
    init(
        imageURL: String,
        title: String,
        description: String,
        creator: String,
        downloads: Int,
        rank: Int? = nil
    ) {
        self.imageURL = imageURL
        self.title = title
        self.description = description
        self.creator = creator
        self.downloads = downloads
        self.rank = rank
    }
}

// MARK: - Mock
extension FrameInfo {
    static let mockFrames: [FrameInfo] = Array(0..<8).map { idx in
        FrameInfo(
            imageURL: "placeholder_\(idx+1)",
            title: "Frame \(idx+1)",
            description: "Description \(idx+1)",
            creator: "PSG \(idx+1)",
            downloads: idx,
            rank: idx
        )
    }
}

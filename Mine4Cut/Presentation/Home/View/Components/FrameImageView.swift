//
//  FrameImageView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

// MARK: - FrameInfo로 View 생성
struct FrameImageView: View {
    let frame: FrameInfo
    let size: FrameSize
    let screenWidth: CGFloat
    
    init(
        frame: FrameInfo,
        size: FrameSize,
        screenWidth: CGFloat
    ) {
        self.frame = frame
        self.size = size
        self.screenWidth = screenWidth
    }
    
    var body: some View {
        AsyncImage(url: URL(string: frame.imageURL)) { image in
            image
                .resizable()
                .frame(
                    width: size.width(screenWidth),
                    height: size.height(screenWidth)
                )
                .clipped()
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(
                    width: size.width(screenWidth),
                    height: size.height(screenWidth)
                )
        }
        .cornerRadius(8)
    }
}

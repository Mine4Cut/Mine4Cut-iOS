//
//  TodayFramesView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct TodayFramesView: View {
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    
    private let parentSize: CGSize
    private let imageHeight: CGFloat
    private let totalHeight: CGFloat
    
    init(parentSize: CGSize) {
        self.parentSize = parentSize
        self.imageHeight = FrameSize.medium.height(parentSize.width)
        self.totalHeight = imageHeight + 44 // Text Height
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            // Text
            HStack {
                Text("오늘의 추천 프레임은?")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            
            // Card List
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                HStack(spacing: 12) {
                    ForEach(frameInfos.indices, id: \.self) { index in
                        FrameImageView(
                            frame: frameInfos[index],
                            size: .medium,
                            screenWidth: parentSize.width
                        )
                    }
                }
            }
        }
        .frame(height: totalHeight)
        .padding(.leading, 16)
    }
}

#Preview {
    GeometryReader { geometry in
        TodayFramesView(parentSize: geometry.size)
    }
}

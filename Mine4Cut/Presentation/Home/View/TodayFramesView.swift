//
//  TodayFramesView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct TodayFramesView: View {
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    let parentSize: CGSize
    
    init(parentSize: CGSize) {
        self.parentSize = parentSize
    }
    
    var body: some View {
        let imageHeight = FrameSize.medium.height(parentSize.width)
        
        // total = imageHeight + text
        let totalHeight = imageHeight + 48
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            // Text
            HStack {
                Text("오늘의 추천 프레임은?")
                    .fontWeight(.bold)
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

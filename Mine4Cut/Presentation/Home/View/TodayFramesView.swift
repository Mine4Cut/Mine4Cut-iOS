//
//  TodayFramesView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct TodayFramesView: View {
    let frameInfos: [FrameInfo]
    
    // MARK: - mockFrame
    init(frameInfos: [FrameInfo] = FrameInfo.mockFrames) {
        self.frameInfos = frameInfos
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(
                alignment: .leading,
                spacing: 12
            ) {
                HStack {
                    Text("오늘의 추천 프레임은?")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                ScrollView(
                    .horizontal,
                    showsIndicators: false
                ) {
                    HStack(spacing: 12) {
                        ForEach(frameInfos.indices, id: \.self) { index in
                            FrameImageView(
                                frame: frameInfos[index],
                                size: .medium,
                                screenWidth: geometry.size.width
                            )
                        }
                    }
                }
            }
        }
        // TODO: Constant로 수정
        .frame(height: 180)
    }
}

#Preview {
    TodayFramesView()
        .padding()
}

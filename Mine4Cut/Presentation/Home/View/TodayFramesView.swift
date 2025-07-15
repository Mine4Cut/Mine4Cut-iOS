//
//  TodayFramesView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct TodayFramesView: View {
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    
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
                            width: 100,
                            height: 140
                        )
                    }
                }
            }
        }
        .frame(height: 140 + 44)
        .padding(.leading, 16)
    }
}

#Preview {
    TodayFramesView()
}

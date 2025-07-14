//
//  TodayFramesView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct TodayFramesView: View {
    var body: some View {
        VStack {
            HStack {
                Text("오늘의 추천 프레임은?")
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(frames) { frame in
                        FrameImageView(frame: frame)
                    }
                }
            }
        }
    }
}

#Preview {
    TodayFramesView()
}

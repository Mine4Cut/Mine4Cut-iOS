//
//  WeeklyRankingFrameView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct WeeklyRankingFrameView: View {
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
                    Text("이번주 인기 프레임 TOP 3")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                ScrollView(
                    .horizontal,
                    showsIndicators: false
                ) {
                    HStack(spacing: 12) {
                        ForEach(frameInfos.indices, id: \.self) { idx in
                            FrameImageView(
                                frame: frameInfos[idx],
                                size: .medium,
                                screenWidth: geometry.size.width
                            )
                            .overlay (
                                Group {
                                    if idx >= 0 && idx <= 2 {
                                        medalOverlay(for: idx)
                                    }
                                },
                                alignment: .bottomTrailing
                            )
                        }
                    }
                }
            }
        }
        // TODO: Constant로 수정
        .frame(height: 180)
    }
    
    // TODO: - 서버에서 rank 정보 넘겨줄 때 확정
    @ViewBuilder
    private func medalOverlay(for rank: Int) -> some View {
        Text(medalEmoji(for: rank))
            .font(.system(size: 20))
    }
    
    private func medalEmoji(for rank: Int) -> String {
        switch rank {
        case 0: return "🥇"
        case 1: return "🥈"
        case 2: return "🥉"
        default: return ""
        }
    }
}

#Preview {
    WeeklyRankingFrameView()
        .padding()
}

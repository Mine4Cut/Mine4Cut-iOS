//
//  WeeklyRankingFrameView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct WeeklyRankingFrameView: View {
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    let parentSize: CGSize
    
    init(parentSize: CGSize) {
        self.parentSize = parentSize
    }
    
    var body: some View {
        let imageHeight = FrameSize.medium.height(parentSize.width)
        
        // total: 44 + List height
        let totalHeight = 44 + imageHeight 
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            HStack {
                Text("이번주 인기 프레임 TOP 3")
                    .font(.system(size: 16, weight: .bold))
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
                            screenWidth: parentSize.width
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
        .frame(height: totalHeight)
        .padding(.leading, 16)
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
    GeometryReader { geometry in
        WeeklyRankingFrameView(parentSize: geometry.size)
    }
}

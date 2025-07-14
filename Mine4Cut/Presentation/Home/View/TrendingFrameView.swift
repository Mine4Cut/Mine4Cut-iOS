//
//  TrendingFrameView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct TrendingFrameView: View {
    // TODO: 서버로부터 받는 데이터
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    
    private let parentSize: CGSize
    private let rowHeight:CGFloat
    private let totalHeight: CGFloat
    
    init(parentSize: CGSize) {
        self.parentSize = parentSize
        self.rowHeight  = FrameSize.small.height(parentSize.width)
        self.totalHeight  = 44 + (rowHeight + 5) * CGFloat(frameInfos.count)
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            // Text
            HStack {
                Text("지금 가장 많이 사용한 프레임은?")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .padding(.horizontal)
            
            // Card List
            List(frameInfos.indices, id: \.self) { idx in
                HStack(spacing: 12) {
                    FrameImageView(
                        frame: frameInfos[idx],
                        size: .small,
                        screenWidth: parentSize.width
                    )
                    
                    // TODO: - Font 설정이 안되서 spacing 5 -> 2
                    VStack(alignment: .leading, spacing: 5) {
                        Text(frameInfos[idx].title)
                            .font(.system(size: 16))
                        
                        Text(frameInfos[idx].creator)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 2) {
                            Image(systemName: "bookmark.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.blue)
                            
                            Text(String(frameInfos[idx].downloads))
                                .font(.system(size: 12))
                                .foregroundStyle(Color.blue)
                        }
                    }
                    
                    Spacer()
                }
                .frame(height: rowHeight)
                // List Style 설정
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 2.5, leading: 20, bottom: 2.5, trailing: 20))
            }
            .listStyle(.plain)
            .scrollDisabled(true)
        }
        .frame(height: totalHeight)
    }
}

#Preview {
    GeometryReader { geometry in
        TrendingFrameView(parentSize: geometry.size)
    }
}

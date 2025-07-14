//
//  TrendingFrameView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct TrendingFrameView: View {
    // TODO: 서버로부터 받는 데잍
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    
    var body: some View {
        GeometryReader { geometry in
            let rowHeight = FrameSize.small.height(geometry.size.width)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("지금 가장 많이 사용한 프레임은?")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                List(frameInfos.indices, id: \.self) { idx in
                    HStack(spacing: 12) {
                        FrameImageView(
                            frame: frameInfos[idx],
                            size: .small,
                            screenWidth: geometry.size.width
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
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 2.5, leading: 20, bottom: 2.5, trailing: 20))
                }
                .listStyle(.plain)
                .frame(height: (rowHeight + 5) * CGFloat(frameInfos.count))
            }
        }
    }
}

#Preview {
    TrendingFrameView()
}

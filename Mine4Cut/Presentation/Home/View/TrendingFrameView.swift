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
                ZStack {
                    // chevron을 제거하기 위해 ZStack으로 처리
                    NavigationLink(destination: DetailView()) {
                        EmptyView()
                    }
                    .opacity(0)
                    
                    HStack(spacing: 12) {
                        FrameImageView(
                            frame: frameInfos[idx],
                            width: 60,
                            height: 80
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
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(height: 80)
                // List Style 설정
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 2.5, leading: 20, bottom: 2.5, trailing: 20))
            }
            .listStyle(.plain)
            .scrollDisabled(true)
        }
        .frame(height: 44 + (80 + 5) * CGFloat(frameInfos.count))
    }
}

#Preview {
    TrendingFrameView()
}

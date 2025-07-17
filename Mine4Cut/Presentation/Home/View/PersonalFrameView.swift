//
//  PersonalFrameView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct PersonalFrameView: View {
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    
    private let itemWidth = (UIApplication.screenWidth - 32 - 16) / 2
    private let itemHeight = ((UIApplication.screenWidth - 32 - 16) / 2) * 1.4
    
    private var columns: [GridItem] {
        [
            GridItem(.fixed(itemWidth)),
            GridItem(.fixed(itemWidth))
        ]
    }
    
    private var calculatedHeight: CGFloat {
        let rowCount = (frameInfos.count + 1) / 2
        return 80 + (itemHeight * CGFloat(rowCount)) + (16 * CGFloat(rowCount - 1))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("이 프레임은 어때요?")
                .font(.system(size: 28, weight: .bold))
                .padding(.top, 8)
            Text("선호장르를 기반으로 추천해드려요")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(frameInfos.indices, id: \.self) { idx in
                    NavigationLink {
                        DetailView()
                    } label: {
                        FrameImageView(
                            frame: frameInfos[idx],
                            width: itemWidth,
                            height: itemHeight
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(height: calculatedHeight)
    }
}

#Preview {
    PersonalFrameView()
}

//
//  PersonalFrameView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

struct PersonalFrameView: View {
    let frameInfos: [FrameInfo] = FrameInfo.mockFrames
    
    private let parentSize: CGSize
    private let gridSpacing: CGFloat = 16
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]
    
    init(parentSize: CGSize) {
        self.parentSize = parentSize
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                Text("이 프레임은 어때요?")
                    .font(.system(size: 16, weight: .bold))
                
                Text("선호장르를 기반으로 추천해드려요")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                
                LazyVGrid(columns: columns, spacing: gridSpacing) {
                    ForEach(frameInfos.indices, id: \.self) { idx in
                        FrameImageView(
                            frame: frameInfos[idx],
                            size: .large,
                            screenWidth: parentSize.width
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        PersonalFrameView(parentSize: geometry.size)
    }
}

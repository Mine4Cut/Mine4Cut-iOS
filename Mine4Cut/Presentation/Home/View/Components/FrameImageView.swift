//
//  FrameImageView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/14/25.
//

import SwiftUI

// MARK: - FrameInfo로 View 생성
struct FrameImageView: View {
    let frame: FrameInfo
    let width: CGFloat
    let height: CGFloat
    
    init(
        frame: FrameInfo,
        width: CGFloat,
        height: CGFloat
    ) {
        self.frame = frame
        self.width = width
        self.height = height
    }
    
    var body: some View {
        // TODO: case 처리
        AsyncImage(url: URL(string: frame.imageURL)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(
                        width: width,
                        height: height
                    )
                    .clipped()
            case .failure(_):
                // TODO: 에러 발생시
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(
                        width: width,
                        height: height
                    )
            case .empty:
                // TODO: ProgessView
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(
                        width: width,
                        height: height
                    )
            @unknown default:
                // TODO: etc
                EmptyView()
            }
        }
        .cornerRadius(8)
    }
}

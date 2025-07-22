//
//  PhotoBoothView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/22/25.
//

import SwiftUI

struct PhotoBoothView: View {
    // MARK: - 촬영된 이미지들
    @State private var photoImages: [UIImage?] = [nil, nil, nil, nil]
    // MARK: - 현재 사진 Idx
    @State private var currentIndex = 0
    
    @State private var showingCamera = false
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Title
            HStack {
                Text("나만의 네컷을 만드는 중입니다.")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.primary)
                    .padding(.top)
                Spacer()
            }
            .padding()
            
            // 2x2 그리드 (중앙 배치)
            VStack(spacing: 0) {
                Spacer()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 2) {
                    ForEach(0..<4, id: \.self) { index in
                        photoFrame(for: index)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // MARK: - Primary Button으로 대체 예정
                Button {
                    // TODO
                } label: {
                    Text("사진 촬영하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 49)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
                .padding()
            }
            
        }
        .navigationTitle("사진사진")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 각 사진 프레임
    private func photoFrame(for index: Int) -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .aspectRatio(0.7, contentMode: .fit)
            .overlay(
                Group {
                    if let image = photoImages[index] {
                        // 촬영된 이미지 표시
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        // 빈 프레임 표시
                        Text("\(index + 1)")
                            .font(.system(size: 48, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
            )
            .clipped()
    }
}

#Preview {
    NavigationStack {
        PhotoBoothView()
    }
}

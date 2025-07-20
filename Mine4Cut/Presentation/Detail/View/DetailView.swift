//
//  DetailView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/17/25.
//

import SwiftUI
import Foundation

struct DetailView: View {
    @State private var currentImageIndex = 0
    @State private var isLiked: Bool = false
    @State private var likeCount: Int = 0
    
    private let frameInfo: FrameInfo
    // TODO: frameImages, tags는 서버로부터 불러와야함
    private let frameImages = ["frame1", "frame2", "frame3", "frame4"]
    private let tags = [
        "연인과",
        "귀여운",
        "따듯한",
        "봄여름가을겨울",
        "Mine4Cut",
        "abcdefghijk",
        "zxcvbnm",
        "qwertyuiop"
    ]

    // MARK: - Initializer
    init(frameInfo: FrameInfo) {
        self.frameInfo = frameInfo
    }
    
    // MARK: - Body
    var body: some View {
        // MARK: - Main ScrollView
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                // MARK: - Image Carousel
                TabView(selection: $currentImageIndex) {
                    ForEach(0..<frameImages.count, id: \.self) { idx in
                        // TODO: AsyncImage나 Image 사용
                        Rectangle()
                            .fill(Color(.systemGray5))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(
                                VStack(spacing: 8) {
                                    Image(systemName: "photo.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)
                                    Text("4컷 프레임 \(idx + 1)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            )
                            .tag(idx)
                    }
                }
                .frame(height: 375)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
                // MARK: - FrameInfo
                VStack(
                    alignment: .leading,
                    spacing: 12
                ) {
                    // MARK: - Title and Like
                    HStack {
                        Text(frameInfo.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        // 좋아요 토글 버튼 (하트 아이콘 + 좋아요 수)
                        Button {
                            isLiked.toggle()
                            likeCount += isLiked ? 1 : -1
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .foregroundColor(isLiked ? .red : .gray)
                                    .font(.system(size: 16))
                                
                                Text("\(likeCount)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 16))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.top)
                    
                    // MARK: - Creator
                    Text(frameInfo.creator)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // MARK: - Description
                    Text(frameInfo.description)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    // MARK: - Tags Section
                    FlowLayout(spacing: 8, lineSpacing: 8) {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .font(.body)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(.systemGray6))
                                .foregroundColor(.secondary)
                                .clipShape(Capsule())
                        }
                    }
                    
                    Spacer()
                        .frame(height: 30)
                }
                .padding(.horizontal, 20) // 좌우 패딩
            }
        }
        .navigationTitle(frameInfo.title)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "이 프레임으로 사진 찍기") {
                // TODO: 사진 찍기로 이동
            }
            .background(Color.white)
            .padding()
        }
    }
}

#Preview {
    NavigationView {
        DetailView(frameInfo: FrameInfo.mockFrames[0])
    }
}

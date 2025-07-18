//
//  DetailView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/17/25.
//

import SwiftUI

struct DetailView: View {
    @State private var currentImageIndex = 0
    @State private var isLiked: Bool = false
    @State private var likeCount: Int = 0
    
    private let frameImages = ["frame1", "frame2", "frame3", "frame4"]
    private let tags = ["연인과", "귀여운", "따듯한", "봄여름가을겨울"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // (375*375) * 5
            TabView(selection: $currentImageIndex) {
                ForEach(0..<frameImages.count, id: \.self) { idx in
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(
                            // TODO: AsyncImage나 Image 사용
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
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Indicator
            HStack {
                Spacer()
                HStack(spacing: 8) {
                    ForEach(0..<4, id: \.self) { index in
                        Circle()
                            .fill(currentImageIndex == index ? Color.primary : Color.gray.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
                Spacer()
            }
            .padding(.top, 12)
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 16) {
                // 제목과 좋아요
                HStack {
                    Text("카카오프렌즈 어피치")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
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
                
                // 작성자
                Text("박성근")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // 설명
                Text("이 프레임은 어쩌구 저쩌구\n어떤 프레임이고 이걸 누구랑 찍는 걸 추천해")
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineSpacing(2)
                
                // 태그들
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .foregroundColor(.secondary)
                            .clipShape(Capsule())
                    }
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                // TODO: 사진 찍기 액션
                print("이 프레임으로 사진 찍기")
            } label: {
                Text("이 프레임으로 사진 찍기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    DetailView()
}

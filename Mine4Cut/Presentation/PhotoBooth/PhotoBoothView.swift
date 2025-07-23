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
    @State private var showingPermissionAlert = false
    
    var body: some View {
        ZStack {
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
                        CameraView.checkCameraPermission { granted in
                            if granted {
                                showingCamera = true
                            } else {
                                showingPermissionAlert = true
                            }
                        }
                    } label: {
                        Text(allPhotosTaken ? "다시 촬영하기" : "사진 촬영하기")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 49)
                            .background(allPhotosTaken ? Color.green : Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                    .padding()
                    
                    // TODO: 완료 버튼
                }
                
            }
        }
        .navigationTitle("사진사진")
        .navigationBarTitleDisplayMode(.inline)
        // TODO: 설정으로 이동
        .alert("카메라 권한이 필요합니다", isPresented: $showingPermissionAlert) {
            Button("확인", role: .cancel) {}
        } message: {
            Text("설정에서 카메라 권한을 허용해주세요.")
        }
        .fullScreenCover(isPresented: $showingCamera) {
            CameraView(sourceType: .camera) { image in
                if let image = image {
                    if let idx = photoImages.firstIndex(where: { $0 == nil }) {
                        photoImages[idx] = image
                    }
                }
                showingCamera = false
            }
            .background(.black)
        }
    }
    
    // 모든 사진이 촬영되었는지 확인
    // TODO: UI 수정까지
    private var allPhotosTaken: Bool {
        photoImages.allSatisfy { $0 != nil }
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
                        VStack {
                            Text("\(index + 1)")
                                .font(.system(size: 48, weight: .medium))
                                .foregroundColor(.gray)
                        }
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

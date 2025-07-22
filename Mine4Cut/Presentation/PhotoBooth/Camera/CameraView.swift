//
//  CameraView.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/22/25.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var cameraService = CameraService()
    @Binding var capturedImages: [UIImage?]
    @Environment(\.dismiss) var dismiss
    
    @State private var countDown = 3
    @State private var isCountingDown = false
    @State private var currentPhotoIndex = 0
    @State private var countdownTask: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            // 카메라 미리보기 화면
            CameraPreview(session: cameraService.session)
                .ignoresSafeArea()
            
            // 카운트다운 표시
            if isCountingDown {
                Text("\(countDown)")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.5))
                            .frame(width: 150, height: 150)
                    )
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.5), value: countDown)
            }
            
            VStack {
                // 상단 정보
                HStack {
                    Text("\(currentPhotoIndex + 1)/4")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    
                    // 닫기 버튼
                    Button {
                        countdownTask?.cancel()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                
                Spacer()
                
                // 찍은 사진을 보여주는 미리보기
                HStack(spacing: 8) {
                    ForEach(0..<4, id: \.self) { index in
                        Group {
                            if let image = capturedImages[index] {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 60, height: 80)
                                    .overlay(
                                        Text("\(index + 1)")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        .overlay(
                            // 현재 촬영할 사진에 하이라이트
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.yellow, lineWidth: index == currentPhotoIndex ? 3 : 0)
                        )
                    }
                }
                .padding()
                
                // 카메라 컨트롤 버튼
                HStack(spacing: 80) {
                    // 사진 촬영 버튼
                    Button {
                        startCountdownAndCapture()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 80, height: 80)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                        }
                    }
                    .disabled(isCountingDown || currentPhotoIndex >= 4)
                }
                .padding(.bottom, 50)
            }
        }
        .task {
            await cameraService.checkPermissions()
        }
        .onChange(of: currentPhotoIndex) { newIndex in
            // 4장 모두 촬영 완료시 자동으로 닫기
            if newIndex >= 4 {
                Task {
                    try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초 대기
                    await MainActor.run {
                        dismiss()
                    }
                }
            }
        }
        .onDisappear {
            countdownTask?.cancel()
        }
    }
    
    // 카운트다운 시작 및 사진 촬영 (async/await 버전)
    private func startCountdownAndCapture() {
        countdownTask?.cancel() // 기존 작업이 있다면 취소
        
        countdownTask = Task {
            await performCountdownAndCapture()
        }
    }
    
    @MainActor
    private func performCountdownAndCapture() async {
        isCountingDown = true
        countDown = 3
        
        // 카운트다운 진행
        for i in stride(from: 3, to: 0, by: -1) {
            guard !Task.isCancelled else {
                isCountingDown = false
                return
            }
            
            countDown = i
            
            if i > 1 {
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초 대기
            }
        }
        
        // 카운트다운 완료 후 사진 촬영
        if !Task.isCancelled {
            await capturePhoto()
            
            withAnimation {
                isCountingDown = false
            }
        }
    }
    
    // 사진 촬영
    private func capturePhoto() async {
        if let capturedImage = await cameraService.capturePhoto() {
            capturedImages[currentPhotoIndex] = capturedImage
            currentPhotoIndex += 1
        } else {
            print("사진 촬영에 실패했습니다.")
        }
    }
}

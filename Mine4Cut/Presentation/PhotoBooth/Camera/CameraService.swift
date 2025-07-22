//
//  CameraService.swift
//  Mine4Cut
//
//  Created by 박성근 on 7/22/25.
//

import AVFoundation
import SwiftUI

class CameraService: NSObject, ObservableObject {
    // MARK: - Properties
    let session = AVCaptureSession()
    
    private var camera: AVCaptureDevice?
    private var input: AVCaptureDeviceInput?
    
    private let output = AVCapturePhotoOutput()
    private var photoCompletion: ((UIImage) -> Void)?
    
    override init() {
        super.init()
        Task {
            await setupSession()
        }
    }
    
    // MARK: - 카메라 연결
    private func setupSession() async {
        do {
            // 세션 설정 시작
            session.beginConfiguration()
            
            // 전면 카메라 디바이스 찾기 (셀프카메라용)
            camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            
            if let camera {
                // 카메라를 입력으로 설정
                input = try AVCaptureDeviceInput(device: camera)
                if session.canAddInput(input!) {
                    session.addInput(input!)
                }
                
                // 사진 출력 추가
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
            }
            
            // 세션 설정 완료
            session.commitConfiguration()
        } catch {
            // TODO: Logger 등록
            print("Camera setup error: \(error)")
        }
    }
    
    // MARK: 카메라 권한 확인 및 세션 시작
    // TODO: Logger로 교체
    func checkPermissions() async {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 권한을 아직 묻지 않은 경우 - 사용자에게 권한 요청
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                await startSession()
            }
        case .restricted:
            // 시스템에 의해 제한된 경우 (부모 제어 등)
            print("카메라 접근이 제한되었습니다.")
        case .authorized:
            // 이미 권한이 있는 경우 - 바로 세션 시작
            await startSession()
        default:
            // 권한이 거부된 경우
            print("권한이 거부되었습니다.")
        }
    }
    
    private func startSession() async {
        if !session.isRunning {
            await Task.detached {
                self.session.startRunning()
            }.value
        }
    }
    
    // MARK: - 사진 촬영
    func capturePhoto() async -> UIImage? {
        await withCheckedContinuation { continuation in
            // 사진 설정
            let settings = AVCapturePhotoSettings()
            settings.flashMode = .auto
            
            // 완료 핸들러 저장
            self.photoCompletion = { image in
                continuation.resume(returning: image)
            }
            
            // 사진 촬영
            output.capturePhoto(with: settings, delegate: self)
        }
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CameraService: AVCapturePhotoCaptureDelegate {
    // 사진 촬영이 완료되었을 때 호출
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Photo capture error: \(error)")
            return
        }
        
        if let imageData = photo.fileDataRepresentation(),
           let image = UIImage(data: imageData) {
            Task { @MainActor in
                self.photoCompletion?(image)
            }
        }
    }
}

//
//  AVCaptureSessionManager.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.02.24.
//

import AVFoundation

final class AVCaptureSessionManager {
    // MARK: - Properties
    let captureSession: AVCaptureSession
    
    // MARK: - Init
    init(delegate: AVCaptureMetadataOutputObjectsDelegate) {
        self.captureSession = AVCaptureSession()
        setupVideoInput()
        setupMetadataOutput(delegate: delegate)
        startCaptureSession()
    }
    
    // MARK: - Private Methods
    private func setupVideoInput() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            fatalError("Failed to get video capture device")
        }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                fatalError("Failed to add video input to capture session")
            }
        } catch {
            fatalError("Failed to create video input: \(error)")
        }
    }
    
    private func setupMetadataOutput(delegate: AVCaptureMetadataOutputObjectsDelegate) {
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            fatalError("Failed to add metadata output to capture session")
        }
    }
    
    private func startCaptureSession() {
        captureSession.startRunning()
    }
}

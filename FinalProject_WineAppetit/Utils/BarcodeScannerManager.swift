//
//  BarcodeScannerManager.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.02.24.
//

import AVFoundation

protocol BarcodeScannerManagerDelegate: AnyObject {
    func barcodeScanningDidFail()
    func barcodeScanningSucceededWithCode(_ barcode: String)
    func barcodeScanningDidStop()
    func cameraLoaded()
}

final class BarcodeScannerManager: NSObject {
    // MARK: - Properties
    var captureSession: AVCaptureSession?
    weak var delegate: BarcodeScannerManagerDelegate?
    
    // MARK: - Inits
    override init() {
        super.init()
        setupCaptureSession()
    }
    
    // MARK: - Private Methods
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        guard let captureSession = captureSession else {
            delegate?.barcodeScanningDidFail()
            return
        }
        
        if !setupVideoInput(for: captureSession) || !setupMetadataOutput(for: captureSession) {
            delegate?.barcodeScanningDidFail()
            return
        }
    }
    
    private func setupVideoInput(for captureSession: AVCaptureSession) -> Bool {
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return false
        }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    private func setupMetadataOutput(for captureSession: AVCaptureSession) -> Bool {
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Methods
    func startScanning() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession?.startRunning()
            DispatchQueue.main.async {
                self.delegate?.cameraLoaded()
            }
        }
    }
    
    func stopScanning() {
        captureSession?.stopRunning()
        delegate?.barcodeScanningDidStop()
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
extension BarcodeScannerManager: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue else {
            return
        }
        delegate?.barcodeScanningSucceededWithCode(stringValue)
    }
}

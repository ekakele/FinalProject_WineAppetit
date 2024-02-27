//
//  BarcodeScannerUIView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.02.24.
//

import UIKit
import AVFoundation

protocol BarcodeScannerUIViewDelegate: AnyObject {
    func barcodeScanningDidFail()
    func barcodeScanningSucceededWithCode(_ barcode: String)
    func barcodeScanningDidStop()
    func cameraLoaded()
    func cameraUnloaded()
}

final class BarcodeScannerUIView: UIView {
    // MARK: - Properties
    weak var delegate: BarcodeScannerUIViewDelegate?
    private let cameraLoadingDelay: Double = 0.5
    var captureSession: AVCaptureSession?
    
    // MARK: - LifeCycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    //MARK: - Override the layerClass
    override class var layerClass: AnyClass  {
        return AVCaptureVideoPreviewLayer.self
    }
    
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
    
    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    // MARK: - Methods
    func updateCamera(with position: AVCaptureDevice.Position) {
        guard let captureSession = captureSession else { return }
        guard let currentCameraInput = captureSession.inputs.first as? AVCaptureDeviceInput else { return }
        guard currentCameraInput.device.position != position else { return }
        
        captureSession.beginConfiguration()
        captureSession.removeInput(currentCameraInput)
        
        guard let newCamera = cameraWithPosition(position: position) else { return }
        
        do {
            let newVideoInput = try AVCaptureDeviceInput(device: newCamera)
            captureSession.addInput(newVideoInput)
            captureSession.commitConfiguration()
        } catch {
            print("Error updating camera input: \(error)")
        }
    }
    
    // MARK: - Private Methods
    private func startScanning() {
        captureSession?.startRunning()
    }
    
    private func stopScanning() {
        DispatchQueue.global().async {
            self.captureSession?.stopRunning()
            self.captureSession = nil
            self.layer.session = nil
            DispatchQueue.main.async {
                self.delegate?.barcodeScanningDidStop()
            }
        }
    }
    
    private func setup() {
        self.clipsToBounds = true
        setupCaptureSession()
        self.layer.backgroundColor = UIColor.clear.cgColor
        backgroundColor = .clear
    }
    
    private func setupCaptureSession() {
        let captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scanningDidFail()
            return
        }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                scanningDidFail()
                return
            }
        } catch {
            print("Error setting up video input: \(error)")
            scanningDidFail()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            scanningDidFail()
            return
        }
        
        self.captureSession = captureSession
        
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
            
            DispatchQueue.main.async {
                self.layer.opacity = 0
                self.layer.session = self.captureSession
                self.layer.videoGravity = .resizeAspectFill
                
                UIView.animate(withDuration: self.cameraLoadingDelay) {
                    self.layer.opacity = 1
                    self.delegate?.cameraLoaded()
                }
            }
        }
    }
    
    private func scanningDidFail() {
        delegate?.barcodeScanningDidFail()
        captureSession = nil
    }
    
    private func found(code: String) {
        delegate?.barcodeScanningSucceededWithCode(code)
    }
    
    private func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: position)
        return discoverySession.devices.first { $0.position == position }
    }
}

// MARK: - AVCaptureMetadataOutputObjects Delegate
extension BarcodeScannerUIView: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue else { return }
        
        found(code: stringValue)
    }
}

//
//  BarcodeScannerUIView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.02.24.
//

import UIKit
import AVFoundation

final class BarcodeScannerUIView: UIView {
    // MARK: - Properties
    weak var delegate: BarcodeScannerManagerDelegate?
    private var barcodeScannerManager: BarcodeScannerManager?
    private var previewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    // MARK: - LifeCycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    // MARK: - PreviewLayer Config
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    // MARK: - Methods
    func startScanning() {
        barcodeScannerManager?.startScanning()
    }
    
    func stopScanning() {
        barcodeScannerManager?.stopScanning()
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        barcodeScannerManager = BarcodeScannerManager()
        barcodeScannerManager?.delegate = self
        setupView()
    }
    
    private func setupView() {
        self.clipsToBounds = true
        backgroundColor = .clear
        
        barcodeScannerManager = BarcodeScannerManager()
        barcodeScannerManager?.delegate = self
        
        setupPreviewLayer()
    }
    
    private func setupPreviewLayer() {
        guard let captureSession = barcodeScannerManager?.captureSession else { return }
        
        previewLayer.session = captureSession
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.backgroundColor = UIColor.clear.cgColor
        
        barcodeScannerManager?.startScanning()
    }
}

// MARK: - BarcodeScannerManagerDelegate
extension BarcodeScannerUIView: BarcodeScannerManagerDelegate {
    func barcodeScanningDidFail() {
        delegate?.barcodeScanningDidFail()
    }
    
    func barcodeScanningSucceededWithCode(_ barcode: String) {
        delegate?.barcodeScanningSucceededWithCode(barcode)
    }
    
    func barcodeScanningDidStop() {
        delegate?.barcodeScanningDidStop()
    }
    
    func cameraLoaded() {
        delegate?.cameraLoaded()
    }
}

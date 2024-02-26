//
//  BarcodeScannerViewRepresentableView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.02.24.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerViewRepresentableView: UIViewRepresentable {
    // MARK: - Enums
    enum ScanningState {
        case closed
        case cameraLoading
        case cameraLoaded
        case searching
        case failure
    }
    
    // MARK: - Properties
    @Binding var currentPosition: AVCaptureDevice.Position
    @Binding var scanningState: ScanningState
    let onBarcodeScanned: (String) -> ()
    
    // MARK: - Coordinator
    final class Coordinator: NSObject, BarcodeScannerUIViewDelegate {
        // MARK: - Properties
        @Binding var scanningState: ScanningState
        let onBarcodeScanned: (String) -> ()
        
        // MARK: - Init
        init(scanningState: Binding<ScanningState>, onBarcodeScanned: @escaping (String) -> ()) {
            self._scanningState = scanningState
            self.onBarcodeScanned = onBarcodeScanned
        }
        
        // MARK: - Methods
        func barcodeScanningDidFail() {
            print("Failed to scan barcode.")
        }
        
        func barcodeScanningDidStop() {
            print("Stopped scanning barcode.")
        }
        
        func barcodeScanningSucceededWithCode(_ barcode: String) {
            onBarcodeScanned(barcode)
        }
        
        func cameraLoaded() {
            withAnimation {
                scanningState = .cameraLoaded
            }
        }
        
        func cameraUnloaded() {
            withAnimation {
                scanningState = .cameraLoading
            }
        }
    }
    
    // MARK: - UIViewRepresentable Methods
    func makeCoordinator() -> Coordinator {
        return Coordinator(scanningState: $scanningState, onBarcodeScanned: onBarcodeScanned)
    }
    
    func makeUIView(context: Context) -> BarcodeScannerUIView {
        let view = BarcodeScannerUIView(frame: .zero)
        view.delegate = context.coordinator
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: BarcodeScannerUIView, context: Context) {
        uiView.updateCamera(with: currentPosition)
        uiView.backgroundColor = .clear
    }
}


#Preview {
    BarcodeScannerViewRepresentableView(
        currentPosition: Binding.constant(AVCaptureDevice.Position.back),
        scanningState: Binding.constant(BarcodeScannerViewRepresentableView.ScanningState.cameraLoading),
        onBarcodeScanned: {_ in }
    )
}

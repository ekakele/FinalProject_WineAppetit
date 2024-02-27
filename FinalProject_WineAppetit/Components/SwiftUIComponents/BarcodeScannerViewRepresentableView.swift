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
    @Binding var scanningState: ScanningState
    let onBarcodeScanned: (String) -> ()
    
    // MARK: - UIViewRepresentable Methods
    func makeUIView(context: Context) -> BarcodeScannerUIView {
        let view = BarcodeScannerUIView(frame: .zero)
        view.delegate = context.coordinator
        view.backgroundColor = .clear
        return view
    }
    
    func updateUIView(_ uiView: BarcodeScannerUIView, context: Context) {
        //                uiView.updateCamera(with: currentPosition)
        //        uiView.backgroundColor = .clear
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(scanningState: $scanningState, onBarcodeScanned: onBarcodeScanned)
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, BarcodeScannerManagerDelegate {
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
            DispatchQueue.main.async {
                self.scanningState = .failure
                print("Failed to scan barcode.")
            }
        }
        
        func barcodeScanningDidStop() {
            DispatchQueue.main.async {
                self.scanningState = .closed
                print("Stopped scanning barcode.")
            }
        }
        
        func barcodeScanningSucceededWithCode(_ barcode: String) {
            DispatchQueue.main.async {
                self.onBarcodeScanned(barcode)
            }
        }
        
        func cameraLoaded() {
            DispatchQueue.main.async {
                self.scanningState = .cameraLoaded
            }
        }
    }
}


#Preview {
    BarcodeScannerViewRepresentableView(
        scanningState: Binding.constant(BarcodeScannerViewRepresentableView.ScanningState.cameraLoading),
        onBarcodeScanned: {_ in }
    )
}

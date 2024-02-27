//
//  BarcodeScannerView.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 27.02.24.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerView: View {
    // MARK: - Properties
    @State private var scanningState: BarcodeScannerViewRepresentableView.ScanningState = .cameraLoading
    @State private var showAlert = false
    @State private var scannedBarcode: String = ""
    @State private var navigateToWineView = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Scan Wine Bottle's Barcode")
                .font(.system(size: 24))
                .bold()
                .padding()
            
            BarcodeScannerViewRepresentableView(/*currentPosition: $currentPosition,*/ scanningState: $scanningState) { barcode in
                print("Scanned barcode: \(barcode)")
                scannedBarcode = barcode
                showAlert = true
                scanningState = .closed
            }
            .frame(width: 300, height: 400)
            .overlay(
                ScanningLineView()
                    .frame(width: 300, height: 400)
            )
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 2)
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Scanned Barcode"),
                    message: Text(scannedBarcode),
                    primaryButton: .default(Text("See Wine Details"), action: {
                        navigateToWineView = true
                    }),
                    secondaryButton: .cancel(Text("Cancel")) {                    }
                )
            }
            .sheet(isPresented: $navigateToWineView) {
                WineDetailsViewControllerRepresentableView(
                    wineID: Int(scannedBarcode) ?? 0, 
                    isBarcode: true
                )
                    .edgesIgnoringSafeArea(.all)
            }
            Spacer()
        }
        .padding(.top, 50)
        
    }
}

#Preview {
    BarcodeScannerView()
}

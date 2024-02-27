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
            setupTitleView
            setupNavigateToDetailsView
            Spacer()
        }
        .padding(.top, 50)
    }
    
    // MARK: - Components
    private var setupNavigateToDetailsView: some View {
        setupBarcodeScannerAlertView
            .sheet(isPresented: $navigateToWineView) {
                wineDetailsRepresentableView
            }
    }
    
    private var setupBarcodeScannerAlertView: some View {
        setupBarcodeScannerView
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Scanned Barcode"),
                    message: Text(scannedBarcode),
                    primaryButton: .default(Text("See Wine Details"), action: {
                        navigateToWineView = true
                    }),
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
    }
    
    private var setupBarcodeScannerView: some View {
        BarcodeScannerViewRepresentableView(scanningState: $scanningState) { barcode in
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
            roundedRectangleView
        )
    }
    
    private var wineDetailsRepresentableView: some View {
        WineDetailsViewControllerRepresentableView(
            wineID: Int(scannedBarcode) ?? 0,
            isBarcode: true
        )
        .edgesIgnoringSafeArea(.all)
    }
    
    private var roundedRectangleView: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Constants.AppColor.textColor, lineWidth: 2)
    }
    
    private var setupTitleView: some View {
        MainTitleView(
            title: "Scan Wine Bottle's Barcode",
            textSize: 24,
            textWeight: .bold,
            textColor: Constants.AppColor.textColor
        )
    }
}

#Preview {
    BarcodeScannerView()
}

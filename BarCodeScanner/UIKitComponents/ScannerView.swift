//
//  ScannerView.swift
//  BarCodeScanner
//
//  Created by Jin on 22/6/24.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var barCode: String
    @Binding var alertItem: AlertItem?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        
    }
    
    final class Coordinator: NSObject, ScannerDelegate {
        
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            scannerView.barCode = barcode
            print(barcode)
        }
        
        func didSurface(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            case .invalidScannedValue:
                scannerView.alertItem = AlertContext.invalidScannedValue
            }
            print(error.rawValue)
        }
        
        
    }
}

#Preview {
    ScannerView(barCode: .constant("123456"), alertItem: .constant(AlertContext.invalidDeviceInput))
}

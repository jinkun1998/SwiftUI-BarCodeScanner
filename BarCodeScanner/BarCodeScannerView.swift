//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Jin on 22/6/24.
//

import SwiftUI

struct BarCodeScannerView: View {
    var body: some View {
        NavigationView{
            VStack{
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer()
                    .frame(height: 60)
                
                Label("Scanned barcode: ", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text("Not yet scanned.")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .bold()
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarCodeScannerView()
}

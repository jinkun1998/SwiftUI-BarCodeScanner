//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Jin on 22/6/24.
//

import SwiftUI

struct BarCodeScannerView: View {
    
    @StateObject var vm = BarCodeScannerViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                ScannerView(barCode: $vm.barCode, alertItem: $vm.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer()
                    .frame(height: 60)
                
                Label("Scanned barcode: ", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(vm.barCode.isEmpty ? "Not yet scanned.": vm.barCode)
                    .font(.largeTitle)
                    .foregroundColor(vm.barCode.isEmpty ? .red : .green)
                    .bold()
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $vm.alertItem) { alertItem in
                Alert(
                    title: Text(alertItem.title),
                    message: Text(alertItem.message),
                    dismissButton: .cancel(Text(alertItem.buttonTitle)) )
            }
        }
    }
}

#Preview {
    BarCodeScannerView()
}

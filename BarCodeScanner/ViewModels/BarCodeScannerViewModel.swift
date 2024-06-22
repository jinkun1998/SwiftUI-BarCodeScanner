//
//  BarCodeScannerViewModel.swift
//  BarCodeScanner
//
//  Created by Jin on 22/6/24.
//

import Foundation

class BarCodeScannerViewModel: ObservableObject {
    @Published var barCode: String = ""
    @Published var alertItem: AlertItem?
}

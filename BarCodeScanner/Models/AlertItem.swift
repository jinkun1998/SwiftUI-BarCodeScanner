//
//  AlertItem.swift
//  BarCodeScanner
//
//  Created by Jin on 22/6/24.
//

import Foundation

struct AlertItem: Identifiable{
    let id = UUID()
    let title: String
    let message: String
    let buttonTitle: String
}

struct AlertContext{
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input", message: "Please check your device input.", buttonTitle: "OK")
    static let invalidScannedValue = AlertItem(title: "Invalid Scanned Value", message: "Please check your scanned value.", buttonTitle: "OK")
}

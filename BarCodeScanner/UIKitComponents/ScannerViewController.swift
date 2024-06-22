//
//  ScannerViewController.swift
//  BarCodeScanner
//
//  Created by Jin on 22/6/24.
//

import UIKit
import AVFoundation

enum CameraError: String{
    case invalidDeviceInput = "There are somethings wrong with the camera."
    case invalidScannedValue = "The scanned value is not EAN8 or EAN13 format."
}

protocol ScannerDelegate: AnyObject {
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}

final class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let captureSession = AVCaptureSession()
    var previewLayer:  AVCaptureVideoPreviewLayer?
    var scannerDelegate: ScannerDelegate?
    
    init(scannerDelegate: ScannerDelegate){
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else{
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else{
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do{
             videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        }
        catch{
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        if (captureSession.canAddInput(videoInput)){
            captureSession.addInput(videoInput)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)){
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13]
        }
        else{
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
}


extension ScannerViewController {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        
//        captureSession.stopRunning()
        scannerDelegate?.didFind(barcode: barcode)
    }
}

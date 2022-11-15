//
//  CameraManager.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import AVFoundation
import UIKit

class CameraManager: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    @Published var image: UIImage?
    @Published var hasCard: Bool = false
    
    var cardInsertedCount = 0 {
        didSet {
            if cardInsertedCount >= 2 {
                DispatchQueue.main.async {
                    self.hasCard = true
                }
            } else {
                DispatchQueue.main.async {
                    self.hasCard = false
                }
            }
        }
    }
    
    var captureSession: AVCaptureSession?
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureInput?
    
    var userIDs = [
        "be87fd5e-4349-4083-b419-8e24661bba10",
        "367c4f10-8613-4eb0-a61b-cad7c67322f1",
        "f33f888e-4a0f-4645-9ce5-baff42a5c7dc",
        "3ac345e2-2a54-46f6-b811-ebdf7d321a74"
    ]
    
    func run() {
        do {
            captureSession = AVCaptureSession()
            
            try configureCamera()
            try configureDeviceInputs()
            
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                self.captureImage()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func configureCamera() throws {
        let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
        self.frontCamera = camera
        
        try camera?.lockForConfiguration()
        camera?.unlockForConfiguration()
        
    }
    
    let output = AVCapturePhotoOutput()

    func configureDeviceInputs() throws {
        guard let captureSession else { return }
        
        if let frontCamera = self.frontCamera {
            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            
            if captureSession.canAddInput(self.frontCameraInput!) {
                captureSession.addInput(self.frontCameraInput!)
            } else {
                print("Input missing")
            }
        } else {
            print("Camera unavailable")
        }
        
        captureSession.addOutput(output)
        
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
    }
    
    func captureImage() {
        let settings = AVCapturePhotoSettings()
        
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160]
        settings.previewPhotoFormat = previewFormat
        
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            
            image = UIImage(data: dataImage)
            getImageColor(image: image!)
        }
    }
    
    func getImageColor(image: UIImage) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let pixelData = image.cgImage!.dataProvider!.data
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
            
            let isCardInserted = (0..<Int(image.size.width)).reduce(true) { partialResult, xValue in
                let xValue = image.size.height / 2
                
                let pixelInfo: Int = ((Int(image.size.width) * Int(xValue)) + Int(xValue)) * 4
                
                let isBlack = CGFloat(data[pixelInfo]) / CGFloat(255.0) < 0.05
                
                return partialResult && isBlack
            }
            
            if isCardInserted {
                self.cardInsertedCount += 1
            } else {
                self.cardInsertedCount = 0
            }
        }
    }
    
    func sendUserID() {
        
    }
}

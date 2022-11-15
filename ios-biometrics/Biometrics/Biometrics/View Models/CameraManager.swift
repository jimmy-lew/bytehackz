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
    
    var currentUserIndex = 0
    
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
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if let dataImage = photo.fileDataRepresentation() {
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
        let user = User.users[currentUserIndex % User.users.count]
        
        let encodedData = user.toJSON()
        
        var urlRequest = URLRequest(url: URL(string: "https://bytehackz.vercel.app/api/session")!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = encodedData
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("error:", error.localizedDescription)
            } else if let response, let data {
                let responseData = try? JSONSerialization.jsonObject(with: data)
                print(responseData)
            }
        }.resume()
        
        currentUserIndex += 1
    }
}

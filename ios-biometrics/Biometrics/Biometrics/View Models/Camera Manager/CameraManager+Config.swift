//
//  CameraManager+Config.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import AVFoundation

extension CameraManager {
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
}

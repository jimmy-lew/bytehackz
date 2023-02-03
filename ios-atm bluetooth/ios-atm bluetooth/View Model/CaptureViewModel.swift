//
//  CaptureViewModel.swift
//  ios-atm bluetooth
//
//  Created by Jia Chen Yee on 1/2/23.
//

import Foundation
import AVFoundation
import UIKit

class CaptureViewModel: NSObject, AVCapturePhotoCaptureDelegate {
    let captureSession = AVCaptureSession()
    
    let stillImageOutput = AVCapturePhotoOutput()
    var error: NSError?

    func setup() {
        
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front).devices
        
        if let captureDevice = devices.first {
            
            captureSession.addInput(try! AVCaptureDeviceInput(device: captureDevice))
            captureSession.sessionPreset = .photo
            
            if captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)
            }
            Task {
                captureSession.startRunning()
            }
        }
    }
    
    var completionHandler: ((UIImage) -> Void)?
    
    func saveImage(completionHandler: @escaping ((UIImage) -> Void)) {
        stillImageOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        self.completionHandler = completionHandler
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let sampleBuffer = photoSampleBuffer,
            let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer:
                                                                                sampleBuffer, previewPhotoSampleBuffer: nil),
           let image = UIImage(data: dataImage)?.rotate(radians: .pi / 2) {
            
            completionHandler?(image)
        }
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

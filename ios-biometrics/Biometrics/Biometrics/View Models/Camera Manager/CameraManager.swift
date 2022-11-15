//
//  CameraManager.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import AVFoundation
import UIKit

class CameraManager: NSObject, ObservableObject {
    
    @Published var successfullyAuthenticated = false
    
    var image: UIImage?
    var lastCardStateChange: Date?
    
    var hasCard: Bool = false {
        didSet {
            if oldValue != hasCard {
                if hasCard {
                    if abs((lastCardStateChange ?? .distantPast).timeIntervalSinceNow) > 1 {
                        sendUserID()
                    }
                } else if successfullyAuthenticated {
                    DispatchQueue.main.async {
                        self.successfullyAuthenticated = false
                    }
                }
                
                lastCardStateChange = Date()
                
                print(hasCard ? "Card in machine" : "Card not in machine")
            }
        }
    }
    
    var cardInsertedCount = 0 {
        didSet {
            hasCard = cardInsertedCount >= 2
        }
    }
    
    var captureSession: AVCaptureSession?
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureInput?
    
    let output = AVCapturePhotoOutput()
    
    var currentUserIndex = 0
}
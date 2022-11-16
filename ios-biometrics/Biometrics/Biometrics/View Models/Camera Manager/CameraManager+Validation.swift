//
//  CameraManager+Validation.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import UIKit

extension CameraManager {
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
        
        var urlRequest = URLRequest(url: getURL(route: "/api/session"))
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = encodedData
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("error:", error.localizedDescription)
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.successfullyAuthenticated = true
                }
            }
        }.resume()
        
        currentUserIndex += 1
    }
}

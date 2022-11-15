//
//  BiometricManager.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import LocalAuthentication

class BiometricManager: ObservableObject {
    
    func authenticateUser() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Try again"
        
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "No") { (isAuthenticated, error) in
            
            if isAuthenticated {
                self.sendBiometricsResult(isSuccess: true)
            } else if let error {
                self.sendBiometricsResult(isSuccess: false)
                print("❌ Fingerprint Error: \(error.localizedDescription)")
            } else {
                self.authenticateUser()
            }
        }
    }
    
    func sendBiometricsResult(isSuccess: Bool) {
        print("✅ Fingerprint: \(isSuccess)")
        
        var urlRequest = URLRequest(url: getURL(route: "/api/auth/biometrics"))
        let encodedData = BiometricsResult(auth: isSuccess, isEmergency: false).toJSON()
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = encodedData
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                self.sendBiometricsResult(isSuccess: isSuccess)
            }
        }.resume()
    }
}

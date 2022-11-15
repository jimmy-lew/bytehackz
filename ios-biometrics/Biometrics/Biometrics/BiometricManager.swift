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
        
        localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "No") { (value, error) in
            
            if !value && error == nil {
                self.authenticateUser()
            } else {
                print("Success")
            }
        }
    }
}

//
//  ResponseManager.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import Foundation
import SwiftUI
import CryptoKit

class ResponseManager: ObservableObject {
    @Published var purposeOfTransaction: String = ""
    @Published var wasUserPressured: SelectionState = .noSelection
    
    @Published var isEmergency = false
    
    @Published var score: Double?
    @Published var isCompleted = false
    
    func calculateScore() {
        isCompleted = false
        var score = 0.0
        
        let dataToSend = SentData(isFailure: wasUserPressured == .selectedYes || isEmergency,
                                  isEmergency: isEmergency,
                                  appScore: score)
        
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(dataToSend)
        
        var urlRequest = URLRequest(url: URL(string: "https://bytehackz.vercel.app/api/auth/confirm")!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = encodedData
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("error:", error.localizedDescription)
            } else {
                self.isCompleted = true
            }
            
        }.resume()
        
        withAnimation {
            self.score = score
        }
    }
}

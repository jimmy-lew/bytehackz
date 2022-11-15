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
    
    func sendResult() {
        isCompleted = false
        
        let score = calculateScore(with: purposeOfTransaction)
        
        let dataToSend = SentData(isFailure: wasUserPressured == .selectedYes || isEmergency,
                                  isEmergency: isEmergency,
                                  appScore: score).toJSON()
        
        print(String(data: dataToSend, encoding: .utf8)!)
        
        var urlRequest = URLRequest(url: getURL(route: "/api/auth/confirm"))
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = dataToSend
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("error:", error.localizedDescription)
            } else if let response  = response as? HTTPURLResponse, response.statusCode == 200 {
                self.isCompleted = true
            }
            
        }.resume()
        
        withAnimation {
            self.score = score
        }
    }
}

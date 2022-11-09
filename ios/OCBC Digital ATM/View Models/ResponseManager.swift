//
//  ResponseManager.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import Foundation
import SwiftUI

class ResponseManager: ObservableObject {
    @Published var purposeOfTransaction: String = ""
    @Published var wasUserPressured: SelectionState = .noSelection
    
    @Published var isEmergency = false
    
    @Published var score: Double?
    
    func calculateScore() {
        var score = 0.0
        
        let dataToSend = SentData(isFailure: wasUserPressured == .selectedYes || isEmergency,
                                  isEmergency: isEmergency,
                                  score: score)
        
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(dataToSend)
        let stringJSON = String(data: encodedData, encoding: .utf8)
        
        withAnimation {
            self.score = score
        }
    }
}

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
    
    @Published var score: Int?
    
    func calculateScore() {
        var score = 0
        
        if wasUserPressured == .selectedYes {
            score = -1000
        }
        
        withAnimation {
            self.score = score
        }
    }
}

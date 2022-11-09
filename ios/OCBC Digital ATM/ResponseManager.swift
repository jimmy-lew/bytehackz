//
//  ResponseManager.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import Foundation

class ResponseManager: ObservableObject {
    @Published var purposeOfTransaction: String = ""
    @Published var wasUserPressured: SelectionState = .noSelection
    
    @Published var isEmergency = false
}

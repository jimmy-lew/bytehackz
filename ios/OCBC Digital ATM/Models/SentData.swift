//
//  SentData.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import Foundation

struct SentData: Codable {
    var isFailure: Bool
    var isEmergency: Bool
    var appScore: Double
    
    func toJSON() -> Data {
        let encoder = JSONEncoder()
        return try! encoder.encode(self)
    }
}

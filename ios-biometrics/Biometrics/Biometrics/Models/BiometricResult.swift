//
//  BiometricResult.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation

struct BiometricsResult: Codable {
    var auth: Bool
    var isEmergency: Bool
    
    enum CodingKeys: CodingKey {
        case auth
        case isEmergency
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(auth ? "1" : "0", forKey: .auth)
        try container.encode(isEmergency, forKey: .isEmergency)
    }
    
    func toJSON() -> Data {
        let encoder = JSONEncoder()
        return try! encoder.encode(self)
    }
}

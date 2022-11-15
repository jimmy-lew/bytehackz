//
//  User.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation

struct User: Codable, ExpressibleByStringLiteral {
    var uuid: String
    
    init(stringLiteral value: StringLiteralType) {
        uuid = value
    }
    
    func toJSON() -> Data {
        let encoder = JSONEncoder()
        return try! encoder.encode(self)
    }
}

//
//  ATMService.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import CoreBluetooth

enum ATMService {
    static let serviceUUID = CBUUID(string: "3b19ad53-35de-4be6-a0f9-1cc3263170df".uppercased())
    static let characteristicUUID = CBUUID(string: "fa896d1e-2aec-45be-936d-4dbdb068f3f7".uppercased())
}

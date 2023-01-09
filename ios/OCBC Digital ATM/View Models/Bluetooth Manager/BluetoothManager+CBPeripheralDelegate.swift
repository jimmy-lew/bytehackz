//
//  BluetoothManager+CBPeripheralDelegate.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import CoreBluetooth

extension BluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("RSSI: \(RSSI.intValue)")
        
        if RSSI.intValue >= -47 && !isConnected {
            isConnected = true
        }
    }
}

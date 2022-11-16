//
//  BluetoothManager+PeripheralManagerDelegate.swift
//  ios-atm bluetooth
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import CoreBluetooth

extension BluetoothManager: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            setupPeripheral()
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        
        connectedCentral = nil
    }
}

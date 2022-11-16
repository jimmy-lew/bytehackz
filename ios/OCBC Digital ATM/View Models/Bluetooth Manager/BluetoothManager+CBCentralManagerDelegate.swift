//
//  BluetoothManager+CBCentralManagerDelegate.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 15/11/22.
//

import Foundation
import CoreBluetooth

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [ATMService.serviceUUID])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        self.peripheral = peripheral
        
        print("Discovered Peripheral: \(peripheral.identifier), Name: \(peripheral.name ?? "(null)"), RSSI: \(RSSI)")
        centralManager.connect(self.peripheral!, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            peripheral.readRSSI()
        }
    }
}

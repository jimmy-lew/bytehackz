//
//  BluetoothManager.swift
//  MacLock macOS
//
//  Created by Jia Chen Yee on 4/5/22.
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject {
    
    var peripheralManager: CBPeripheralManager!
    
    var transferCharacteristic: CBMutableCharacteristic?
    var connectedCentral: CBCentral?
    var dataToSend = Data()
    var sendDataIndex: Int = 0
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: [CBPeripheralManagerOptionShowPowerAlertKey: true])
        
    }
    
    deinit {
        peripheralManager.stopAdvertising()
    }
    
    func setupPeripheral() {
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [ATMService.serviceUUID]])
        
        let transferCharacteristic = CBMutableCharacteristic(type: ATMService.characteristicUUID,
                                                             properties: [.notify, .writeWithoutResponse],
                                                             value: nil,
                                                             permissions: [.readable, .writeable])
        
        let transferService = CBMutableService(type: ATMService.serviceUUID, primary: true)
        
        transferService.characteristics = [transferCharacteristic]
        
        peripheralManager.add(transferService)
        
        self.transferCharacteristic = transferCharacteristic
    }
}

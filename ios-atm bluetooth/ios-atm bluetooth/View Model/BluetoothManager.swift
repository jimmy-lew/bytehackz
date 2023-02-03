//
//  BluetoothManager.swift
//  MacLock macOS
//
//  Created by Jia Chen Yee on 4/5/22.
//

import Foundation
import CoreBluetooth
import SwiftUI
import MapKit
import FirebaseDatabase
import FirebaseStorage
import CoreLocation

class BluetoothManager: NSObject, ObservableObject {
    
    var peripheralManager: CBPeripheralManager!
    
    var transferCharacteristic: CBMutableCharacteristic?
    var connectedCentral: CBCentral?
    var dataToSend = Data()
    var sendDataIndex: Int = 0
    var ref: DatabaseReference!
    
    let captureViewModel = CaptureViewModel()
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: [CBPeripheralManagerOptionShowPowerAlertKey: true])
        
        ref = Database.database(url: "https://ngee-ann-city-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        
        let refHandle = ref.child("helpme").observe(DataEventType.value, with: { snapshot in
            guard let data = snapshot.value as? NSDictionary,
                  let mapsURL = data["mapsURL"] as? String,
                  let imageURL = data["imageURL"] as? String,
                  let dateTime = data["datetime"] as? Double
            else { return }
            
            if abs(Date(timeIntervalSince1970: dateTime).timeIntervalSinceNow) < 10 {
                // ACTIVE
                self.emergencyModeActive(mapsURL: mapsURL, appleMapsEmbedURL: imageURL)
            }
        })
        
        captureViewModel.setup()
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
    
    func emergencyModeActive(mapsURL: String, appleMapsEmbedURL: String) {
        
        Task {
       // https://www.google.com/maps/search/?api=1&query=1.3332092575741343%2C103.77494045542905
            let intermediateOutput = mapsURL.components(separatedBy: "%2C")
            guard let latitude = intermediateOutput.first?.components(separatedBy: "=").last,
                  let longitude = intermediateOutput.last else { return }
            
            let geocoder = CLGeocoder()
            let landmark = try! await geocoder.reverseGeocodeLocation(CLLocation(latitude: CLLocationDegrees(latitude)!, longitude: CLLocationDegrees(longitude)!))
            
            let locationName = landmark.first?.name
            
            captureViewModel.saveImage { [self] image in
                let imageURL = uploadImage(image)
                
                if let locationName {
                    send(username: "OCBC Emergency Help", message: "A user has reported an emergency at **ATM: 00001**, \(locationName)", images: [appleMapsEmbedURL, imageURL], mapsLink: mapsURL)
                } else {
                    send(username: "OCBC Emergency Help", message: "A user has reported an emergency at **ATM: 00001**", images: [appleMapsEmbedURL, imageURL], mapsLink: mapsURL)
                }
            }
        }
    }
    
    func uploadImage(_ image: UIImage) -> String {
        let storage = Storage.storage()
        
        let fileName = "\(UUID().uuidString).jpeg"
        
        let storageRef = storage.reference().child(fileName)
        
        let imageURL = "https://firebasestorage.googleapis.com/v0/b/ngee-ann-city.appspot.com/o/\(fileName)?alt=media"
        
        storageRef.putData(image.jpegData(compressionQuality: 1)!) { metadata, error in
        }
        
        return imageURL
    }
    
    func send(username: String, message: String, images: [String], mapsLink: String) {
        let url = URL(string: "https://discord.com/api/webhooks/1067640780254097471/Q1pMlMPSXjzkhsx-iqDqzDyOD-7kJd_YOVQIwhFv4rzWiSBAm6R2ncjCcjBbeab3q47q")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let httpBody = Data("""
        {
            "content": "\(message)",
            "tts": false,
            "username": "\(username)",
            "embeds": [{
                "description": "[Open in Google Maps](\(mapsLink))",
                "image": {
                    "url": "\(images.first!)"
                }
            }, {
                "description": "ATM Camera",
                "image": {
                    "url": "\(images.last!)"
                }
            }]
        }
        """.utf8)
        
        request.httpBody = httpBody
        print(String(data: httpBody, encoding: .utf8)!)
        
        URLSession.shared.dataTask(with: request) { data, respose, error in
            
            if let data = data {
                print(String(data: data, encoding: .utf8))
            } else if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }

}

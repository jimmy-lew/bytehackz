//
//  ResponseManager.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import Foundation
import SwiftUI
import CryptoKit
import MapKit
import CoreLocation
import FirebaseStorage
import FirebaseDatabase
import FirebaseDatabaseSwift

class ResponseManager: ObservableObject {
    @Published var purposeOfTransaction: String = ""
    @Published var wasUserPressured: SelectionState = .noSelection
    
    var locationManager = CLLocationManager()
    var bluetoothManager: BluetoothManager!
    var ref: DatabaseReference!
    
    @Published var isEmergency = false {
        didSet {
            if let lat = locationManager.location?.coordinate.latitude,
               let long = locationManager.location?.coordinate.longitude {
                let url = "https://www.google.com/maps/search/?api=1&query=\(lat)%2C\(long)"
                Task {
                    let imageURL = await getMapImageURL()
                    
                    try! await self.ref.child("helpme").setValue([
                        "mapsURL": url,
                        "imageURL": imageURL,
                        "datetime": Date.now.timeIntervalSince1970
                    ])
                }
            }
        }
    }
    
    func getMapImageURL() async -> String {
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = locationManager.location!.coordinate
        
        let options = MKMapSnapshotter.Options()
        options.size = .init(width: 500, height: 500)
        options.mapType = .standard
        options.showsBuildings = true
        options.region = mapRegion
        options.scale = 1
        
        let snapshotter = MKMapSnapshotter(options: options)
        
        let snapshot = try! await snapshotter.start()
        
        print(snapshot.image)
        
        let storage = Storage.storage()
        
        let fileName = "\(UUID().uuidString).jpeg"
        
        let storageRef = storage.reference().child(fileName)
        
        let imageURL = "https://firebasestorage.googleapis.com/v0/b/ngee-ann-city.appspot.com/o/\(fileName)?alt=media"
        
        
        storageRef.putData(snapshot.image.jpegData(compressionQuality: 1)!) { metadata, error in
        }
        return imageURL
    }
    
    func send(username: String, message: String, image: String, mapsLink: String) {
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
                    "url": "\(image)"
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

    @Published var isEmergency = false
    
    @Published var score: Double?
    @Published var isCompleted = false
    
    func sendResult() {
        isCompleted = false
        
        let score = calculateScore(with: purposeOfTransaction)
        
        let dataToSend = SentData(isFailure: wasUserPressured == .selectedYes || isEmergency,
                                  isEmergency: isEmergency,
                                  appScore: score).toJSON()
        
        print(String(data: dataToSend, encoding: .utf8)!)
        
        var urlRequest = URLRequest(url: getURL(route: "/api/auth/confirm"))
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = dataToSend
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("error:", error.localizedDescription)
            } else if let response  = response as? HTTPURLResponse, response.statusCode == 200 {
                self.isCompleted = true
            }
            
        }.resume()
        
        withAnimation {
            self.score = score
        }
    }
    
    init() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        ref = Database.database(url: "https://ngee-ann-city-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        
    }
}

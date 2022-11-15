//
//  BiometricsApp.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import SwiftUI

@main
struct BiometricsApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { scenePhase in
            if scenePhase == .background {
                var urlRequest = URLRequest(url: getURL(route: "/api/auth/biometrics"))
                let encodedData = BiometricsResult(auth: false, isEmergency: true).toJSON()
                
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                urlRequest.httpBody = encodedData
                
                URLSession.shared.dataTask(with: urlRequest) { _, _, _ in
                }.resume()
            }
        }
    }
}

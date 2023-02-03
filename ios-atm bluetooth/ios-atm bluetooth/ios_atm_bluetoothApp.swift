//
//  ios_atm_bluetoothApp.swift
//  ios-atm bluetooth
//
//  Created by Jia Chen Yee on 15/11/22.
//

import SwiftUI
import Firebase

@main
struct ios_atm_bluetoothApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

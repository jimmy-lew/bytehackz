//
//  ContentView.swift
//  Biometrics
//
//  Created by Jia Chen Yee on 15/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var biometricManager = BiometricManager()
    @StateObject var cameraManager = CameraManager()
    
    var body: some View {
        if cameraManager.hasCard {
            Image(systemName: "checkmark")
                .font(.system(size: 36))
        } else {
            Image(systemName: "xmark")
                .font(.system(size: 36))
                .onAppear {
                    cameraManager.run()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

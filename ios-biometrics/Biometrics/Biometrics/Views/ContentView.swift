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
        Group {
            if cameraManager.successfullyAuthenticated {
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
        .onChange(of: cameraManager.successfullyAuthenticated) { successfullyAuthenticated in
            if successfullyAuthenticated {
                biometricManager.authenticateUser()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

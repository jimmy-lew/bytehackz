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
        Color.black
            .edgesIgnoringSafeArea(.all)
            .statusBarHidden()
        .onAppear {
            cameraManager.run()
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

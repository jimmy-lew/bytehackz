//
//  ContentView.swift
//  ios-atm bluetooth
//
//  Created by Jia Chen Yee on 15/11/22.
//

import SwiftUI

struct ContentView: View {
    
    var bluetoothManager = BluetoothManager()
    
    var body: some View {
        Color.black
            .statusBarHidden()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

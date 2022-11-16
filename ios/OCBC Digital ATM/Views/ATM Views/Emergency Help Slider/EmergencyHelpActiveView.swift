//
//  EmergencyHelpActiveView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import SwiftUI

struct EmergencyHelpActiveView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Text("Emergency Mode Activated")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("The authorities have been notified")
                    .foregroundColor(.white)
            }
        }
    }
}

struct EmergencyHelpActiveView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyHelpActiveView()
    }
}

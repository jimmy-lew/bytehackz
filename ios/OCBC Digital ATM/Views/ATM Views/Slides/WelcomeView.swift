//
//  WelcomeView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI
import LocalAuthentication

struct WelcomeView: View {
    
    @Binding var selected: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("👋 Hello!")
                .font(.system(size: 30, weight: .bold))
            
            Text("To complete your ATM transaction, please respond to the following questions.\n\nIf you are in distress, or feel threatened, swipe on the **Emergency Help** below.")
            
            Button {
                let localAuthenticationContext = LAContext()
                localAuthenticationContext.localizedFallbackTitle = "Try again."
                
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To verify your identity") { (value, error) in
                    if value {
                        withAnimation {
                            selected += 1
                        }
                    }
                }
            } label: {
                ZStack {
                    Color.red
                        .cornerRadius(8)
                    Text("Continue")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            .frame(height: 56)
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(selected: .constant(1))
    }
}

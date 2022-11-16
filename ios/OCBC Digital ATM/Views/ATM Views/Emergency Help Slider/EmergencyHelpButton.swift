//
//  EmergencyHelpButton.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct EmergencyHelpButton: View {
    
    @Binding var isEmergency: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if isEmergency {
                EmergencyHelpActiveView()
            } else {
                EmergencyHelpSliderView(isEmergency: $isEmergency)
            }
        }
        .clipped()
        .cornerRadius(8)
        .frame(height: 56)
        .padding([.horizontal, .bottom])
    }
}

struct EmergencyHelpButton_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyHelpButton(isEmergency: .constant(false))
    }
}

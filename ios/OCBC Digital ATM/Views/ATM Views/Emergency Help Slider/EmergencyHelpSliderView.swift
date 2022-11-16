//
//  EmergencyHelpSliderView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import SwiftUI

struct EmergencyHelpSliderView: View {
    
    @Binding var isEmergency: Bool
    @State var offset = 0.0
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .opacity(0.1)
                
                Text("Emergency Help")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            
            ZStack {
                LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 56, height: 56)
                    .cornerRadius(8)
                
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged { dragValue in
                        offset = dragValue.translation.width
                    }
                    .onEnded { dragValue in
                        if dragValue.translation.width > reader.size.width / 2 {
                            withAnimation {
                                isEmergency = true
                            }
                        } else {
                            withAnimation(.spring()) {
                                offset = 0
                            }
                        }
                    }
            )
        }
    }
}

struct EmergencyHelpSliderView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyHelpSliderView(isEmergency: .constant(false))
    }
}

//
//  EmergencyHelpButton.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct EmergencyHelpButton: View {
    
    @State var offset = 0.0
    
    var body: some View {
        ZStack(alignment: .leading) {
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
                            withAnimation(.spring()) {
                                offset = 0
                            }
                        }
                )
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
        EmergencyHelpButton()
    }
}

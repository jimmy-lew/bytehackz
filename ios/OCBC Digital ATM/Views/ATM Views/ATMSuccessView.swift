//
//  ATMSuccessView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import SwiftUI

struct ATMSuccessView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var scale = 0.01
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.red)
                .scaleEffect(scale)
            
            Text("You're all set!")
                .font(.system(size: 32, weight: .bold))
                .padding(.top)
            Text("Continue your transaction on the ATM.")
                .font(.system(size: 16))
            Spacer()
            
            Button {
                dismiss()
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
            .padding()
        }
        .onAppear {
            withAnimation(.spring(dampingFraction: 0.5)) {
                scale = 1
            }
        }
    }
}

struct ATMSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        ATMSuccessView()
    }
}

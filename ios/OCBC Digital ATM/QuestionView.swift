//
//  QuestionView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct QuestionView: View {
    
    var title: String = "Were you pressured to make this transaction?"
    var subtitle: String = "Please answer as truthfully as possible."
    
    @Binding var selected: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 30, weight: .bold))
            
            Text(subtitle)
            
            Button {
                withAnimation {
                    selected += 1
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                    Text("Yes")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
            .frame(height: 56)
            
            Button {
                withAnimation {
                    selected += 1
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                    Text("No")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
            .frame(height: 56)
            
            Spacer()
        }
        .padding()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(selected: .constant(1))
    }
}

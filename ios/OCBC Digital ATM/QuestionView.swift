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
    @Binding var selectionState: SelectionState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 30, weight: .bold))
            
            Text(subtitle)
            
            Button {
                withAnimation {
                    selectionState = .selectedYes
                    selected += 1
                }
            } label: {
                ZStack {
                    if selectionState == .selectedYes {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.red)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray)
                    }
                    Text("Yes")
                        .foregroundColor(selectionState == .selectedYes ? .white : .black)
                        .fontWeight(.bold)
                }
            }
            .frame(height: 56)
            
            Button {
                withAnimation {
                    selectionState = .selectedNo
                    selected += 1
                }
            } label: {
                ZStack {
                    if selectionState == .selectedNo {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.red)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray)
                    }
                    Text("No")
                        .foregroundColor(selectionState == .selectedNo ? .white : .black)
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
        QuestionView(selected: .constant(1), selectionState: .constant(.noSelection))
    }
}

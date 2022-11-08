//
//  OpenEndedQuestion.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct OpenEndedQuestion: View {
    
    @State var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What is the purpose of this transaction?")
                .font(.system(size: 30, weight: .bold))
            
            Text("Are you sending this money to someone? Why?")
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray)
                HStack {
                    TextField("Text", text: $text)
                        .padding()
                    Button {
                        
                    } label: {
                        Image(systemName: "mic")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                
            }
            .frame(height: 56)
            
            Spacer()
        }
        .padding()
    }
}

struct OpenEndedQuestion_Previews: PreviewProvider {
    static var previews: some View {
        OpenEndedQuestion()
    }
}

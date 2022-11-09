//
//  OpenEndedQuestion.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct OpenEndedQuestion: View {
    
    @State var text: String = ""
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @State var isTranscribing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What is the purpose of this transaction?")
                .font(.system(size: 30, weight: .bold))
            
            Text("Are you sending this money to someone? Why?")
            
            ScrollView {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                    
                    HStack(alignment: .top) {
                        TextEditor(text: $text)
                            .padding(8)
                        
                        Button {
                            if isTranscribing {
                                let transcribedText = speechRecognizer.transcript
                                speechRecognizer.stopTranscribing()
                                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                                    text = transcribedText
                                }
                            } else {
                                speechRecognizer.transcribe()
                            }
                            
                            isTranscribing.toggle()
                        } label: {
                            Image(systemName: isTranscribing ? "mic.fill" : "mic")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
                .frame(height: 100)
                
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            speechRecognizer.reset()
        }
        .onChange(of: speechRecognizer.transcript) { newValue in
            text = newValue
        }
    }
}

struct OpenEndedQuestion_Previews: PreviewProvider {
    static var previews: some View {
        OpenEndedQuestion()
    }
}

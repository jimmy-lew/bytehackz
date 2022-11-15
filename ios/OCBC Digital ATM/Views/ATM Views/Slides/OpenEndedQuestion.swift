//
//  OpenEndedQuestion.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct OpenEndedQuestion: View {
    
    @Binding var text: String
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @FocusState var isEditing: Bool
    
    @State var isTranscribing = false
    
    var continueButtonPressed: (() -> ())
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What is the purpose of this transaction?")
                .font(.system(size: 30, weight: .bold))
            
            Text("Are you sending this money to someone? Why?")
            
            ScrollView {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray)
                        .padding(1)
                    
                    HStack(alignment: .top) {
                        TextEditor(text: $text)
                            .focused($isEditing)
                            .padding(8)
                        
                        Button {
                            isEditing = false
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
                
                Button {
                    continueButtonPressed()
                } label: {
                    ZStack {
                        Color.red
                            .cornerRadius(8)
                        Text("Continue")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .disabled(text.isEmpty)
                .opacity(text.isEmpty ? 0.5 : 1)
                .frame(height: 56)
            }
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
        OpenEndedQuestion(text: .constant("")) {
            
        }
    }
}

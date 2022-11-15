//
//  ATMView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct ATMView: View {
    
    @State var tabSelection = 0
    @State var selection = 0
    
    @StateObject var responseManager = ResponseManager()
    
    var body: some View {
        if responseManager.score == nil {
            VStack {
                CustomPageControl(selection: selection)
                    .padding()
                
                TabView(selection: $tabSelection) {
                    WelcomeView(selected: $tabSelection)
                        .tag(0)
                    QuestionView(selected: $tabSelection, selectionState: $responseManager.wasUserPressured)
                        .tag(1)
                    OpenEndedQuestion(text: $responseManager.purposeOfTransaction) {
                        responseManager.calculateScore()
                    }
                    .tag(2)
                }
                .tabViewStyle(.page)
                .tint(.clear)
                .onChange(of: tabSelection) { newValue in
                    withAnimation(.spring()) {
                        selection = newValue
                    }
                }
                
                EmergencyHelpButton(isEmergency: $responseManager.isEmergency)
            }
            .interactiveDismissDisabled(true)
        } else if responseManager.isCompleted {
            ATMSuccessView()
                .interactiveDismissDisabled(false)
        } else {
            LoadingView()
                .interactiveDismissDisabled()
        }
    }
}

struct ATMView_Previews: PreviewProvider {
    static var previews: some View {
        ATMView()
    }
}

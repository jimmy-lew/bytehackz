//
//  ATMWelcomeView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct ATMWelcomeView: View {
    
    @State var userScore = 0
    
    @State var tabSelection = 0
    @State var selection = 0
    
    @State var wasUserPressured: SelectionState = .noSelection
    
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 7.5)
                    .fill(selection == 0 ? .red : .gray)
                    .frame(width: selection == 0 ? 30 : 15, height: 15)
                
                RoundedRectangle(cornerRadius: 7.5)
                    .fill(selection == 1 ? .red : .gray)
                    .frame(width: selection == 1 ? 30 : 15, height: 15)
                
                RoundedRectangle(cornerRadius: 7.5)
                    .fill(selection == 2 ? .red : .gray)
                    .frame(width: selection == 2 ? 30 : 15, height: 15)
                Spacer()
            }
            .padding()
            TabView(selection: $tabSelection) {
                WelcomeView(selected: $tabSelection)
                    .tag(0)
                QuestionView(selected: $tabSelection, selectionState: $wasUserPressured)
                    .tag(1)
                OpenEndedQuestion()
                    .tag(2)
            }
            .tabViewStyle(.page)
            .tint(.clear)
            .onChange(of: tabSelection) { newValue in
                withAnimation(.spring()) {
                    selection = newValue
                }
            }
            
            EmergencyHelpButton()
        }
    }
}

struct ATMWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ATMWelcomeView()
    }
}

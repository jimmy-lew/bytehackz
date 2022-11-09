//
//  HomeViewActionButton.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct HomeViewActionButton: View {
    
    var title: String
    var systemName: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(uiColor: .systemGray5))
                    .frame(width: 40)
                Image(systemName: systemName)
                    .foregroundColor(Color(uiColor: .systemGray))
                    .font(.system(size: 16))
            }
            
            Text(title)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(uiColor: .systemGray))
                .font(.system(size: 12))
        }
    }
}

struct HomeViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewActionButton(title: "Transfers", systemName: "banknote")
    }
}

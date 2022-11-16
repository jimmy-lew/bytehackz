//
//  LoadingView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 15/11/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            
            ProgressView()
            
            Text("Uploading Responses…")
                .font(.system(size: 32, weight: .bold))
                .padding(.vertical)
            Text("Please wait.")
                .font(.system(size: 16))
            
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

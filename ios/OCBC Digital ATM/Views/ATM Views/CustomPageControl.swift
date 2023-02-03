//
//  CustomPageControl.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 9/11/22.
//

import SwiftUI

struct CustomPageControl: View {
    
    var selection: Int
    
    var body: some View {
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
    }
}

struct CustomPageControl_Previews: PreviewProvider {
    static var previews: some View {
        CustomPageControl(selection: 0)
    }
}

//
//  ContentView.swift
//  OCBC Digital ATM
//
//  Created by Jia Chen Yee on 8/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var isSheetPresented = false
    
    @StateObject var bluetoothManager = BluetoothManager()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.white
                LinearGradient(colors: [.white, Color(uiColor: .systemGray6)], startPoint: .top, endPoint: .bottom)
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                            .font(.system(size: 18, weight: .medium))
                    }
                    Spacer()
                }
                
                Image("hero")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                Text("Welcome back!")
                    .font(.system(size: 32, weight: .bold))
                
                Button {
                    isSheetPresented.toggle()
                } label: {
                    ZStack {
                        LinearGradient(colors: [.teal, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .cornerRadius(8)
                        Text("Log In")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .frame(height: 56)
                
                Button {
                    isSheetPresented.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray)
                        HStack(spacing: 4) {
                            Text("Login with")
                            Image("singpass")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 12)
                                .offset(y: 4)
                            Text("Mobile")
                        }
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                    }
                }
                .frame(height: 56)
                .padding(.bottom)
                
                HStack(alignment: .top) {
                    HomeViewActionButton(title: "Transfers", systemName: "banknote")
                    Spacer()
                    HomeViewActionButton(title: "Scan\n& Pay", systemName: "qrcode.viewfinder")
                    Spacer()
                    HomeViewActionButton(title: "Pay bills", systemName: "doc.text")
                    Spacer()
                    HomeViewActionButton(title: "Your\nwealth", systemName: "chart.bar")
                    Spacer()
                    VStack {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(uiColor: .systemGray))
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .frame(width: 40, height: 40)
                        
                        Text("More\nServices")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(uiColor: .systemGray))
                            .font(.system(size: 12))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.white)
                .cornerRadius(24)
            }
            .padding()
        }
        .sheet(isPresented: $isSheetPresented) {
            ATMView()
        }
        .onChange(of: bluetoothManager.isConnected) { isConnected in
            if isConnected {
                isSheetPresented = true
            }
        }
        .onChange(of: isSheetPresented) { isSheetPresented in
            if !isSheetPresented {
                bluetoothManager.isConnected = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

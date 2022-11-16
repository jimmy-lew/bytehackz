//
//  ContentView.swift
//  ios-timekeeper Watch App
//
//  Created by Jia Chen Yee on 16/11/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State var isStarted = false
    @State var time = 0
    
    let session = try! HKWorkoutSession.init(healthStore: .init(), configuration: .init())
    
    var body: some View {
        Group {
            if !isStarted {
                Button("Start") {
                    withAnimation {
                        isStarted = true
                    }
                }
                .tint(.green)
                .padding()
            } else {
                Text("\(Double(time) / 10)s")
            }
        }
        .onAppear {
            session.startActivity(with: .now)
        }
        .onReceive(timer) { _ in
            if isStarted {
                time += 1
                
                if time % 600 == 0 {
                    session.endCurrentActivity(on: .now)
                    session.startActivity(with: .now)
                }
                
                switch time {
                case 3000: // 5m
                    WKInterfaceDevice.current().play(.notification)
                case 3595: // 6m
                    WKInterfaceDevice.current().play(.notification)
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        WKInterfaceDevice.current().play(.notification)
                    }
                case 4190: // 7m
                    WKInterfaceDevice.current().play(.notification)
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        WKInterfaceDevice.current().play(.notification)
                    }
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        WKInterfaceDevice.current().play(.notification)
                    }
                default: break
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

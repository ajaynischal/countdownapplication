//
//  Home.swift
//  countdownapplication
//
//  Created by Ajay Nischal(UST,US) on 4/7/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack{
            Text("Countdown Timer")
                .font(.title2.bold())
                .foregroundColor(.white)
            GeometryReader { proxy in
                VStack(spacing: 15) {
                    //Timer Ring
                    ZStack{
                        Circle()
                            .fill(.white.opacity(0.03))
                            .padding(-40)
                        
                        Circle()
                            .fill(Color("BG"))
                        
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .stroke(Color("RTeal").opacity(0.7), lineWidth: 10)
                            .rotationEffect(.init(degrees: -90))
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity,
                       alignment: .center)
            }
        }
        .padding()
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimerModel())
    }
}

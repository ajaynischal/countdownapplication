//
//  Home.swift
//  countdownapplication
//
//  Created by Ajay Nischal(UST,US) on 4/7/24.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var timerModel: TimerModel
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
                            .trim(from: 0, to: timerModel.progress)
                            .stroke(.white.opacity(0.03), lineWidth: 80)
                        
                        //Shadow creation
                        Circle()
                            .stroke(Color("RTeal"), lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-2)
                        
                        Circle()
                            .fill(Color("BG"))
                        
                        Circle()
                            .trim(from: 0, to: timerModel.progress )
                            .stroke(Color("RTeal").opacity(0.7), lineWidth: 10)
                        // .rotationEffect(.init(degrees: -90))
                        
                        //Knob
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color("RTeal"))
                                .frame(width: 30, height: 30)
                                .overlay(content: {
                                    Circle()
                                        .fill(.white)
                                        .padding(5)
                                })
                                .frame(width: size.width,
                                       height:size.height,
                                       alignment: .center)
                            //Rotated view
                                .offset(x: size.height / 2)
                                .rotationEffect(.init(degrees: timerModel.progress * 360))
                            
                            
                        }
                        Text(timerModel.timerStringValue)
                            .font(.system(size: 45, weight: .light))
                            .rotationEffect(.init(degrees: 90))
                            .animation(.none, value: timerModel.progress)
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: timerModel.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity,
                           alignment: .center)
                    
                    Button {
                        if timerModel.isStarted{
                            timerModel.stopTimer()
                            //Cancelling all Notifications
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            
                        } else{
                            timerModel.addNewTimer = true
                        }
                    } label: {
                        Image(systemName: !timerModel.isStarted ? "timer" : "stop.fill")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .background{
                                Circle()
                                    .fill(Color("RTeal"))
                            }
                            .shadow(color: Color("RTeal"), radius: 8, x: 0, y: 0)
                    }
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
        .overlay(content: {
            ZStack {
                Color.black
                    .opacity(timerModel.addNewTimer ? 0.25 : 0)
                    .onTapGesture {
                        timerModel.hour = 0
                        timerModel.minutes = 0
                        timerModel.seconds = 0
                        timerModel.addNewTimer = false
                    }
                
                NewTimerView()
                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                    .offset(y: timerModel.addNewTimer ? 0 : 400)
            }
            .animation(.easeInOut, value: timerModel.addNewTimer)
        })
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if timerModel.isStarted {
                timerModel.updateTimer()
            }
        }
        .alert("You did it! Great Job!", isPresented: $timerModel.isFinished) {
            Button("Start New", role: .cancel) {
                timerModel.stopTimer()
                timerModel.addNewTimer = true
            }
            Button("Close", role: .destructive) {
                timerModel.stopTimer()
            }
        }
        
    }
    //New timer Bottom Sheet
    @ViewBuilder
    func NewTimerView()->some View {
        VStack(spacing: 15) {
            Text("Add New Timer")
                .font(.title2.bold())
                .foregroundStyle(.white)
                .padding(.top, 10)
            
            HStack(spacing: 15) {
                Text("\(timerModel.hour) hr")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.20))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 12, hint: "hr") { value in
                            timerModel.hour = value
                        }
                    }
                
                Text("\(timerModel.minutes) min")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.20))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 60, hint: "min") { value in
                            timerModel.minutes = value
                        }
                    }
                
                Text("\(timerModel.seconds) sec")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.20))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 60, hint: "sec") { value in
                            timerModel.seconds = value
                        }
                    }
            }
            .padding(.top, 20)
            
            Button{
                timerModel.startTimer()
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background {
                        Capsule()
                            .fill(Color("RTeal"))
                    }
            }
            .disabled(timerModel.seconds == 0)
            .opacity(timerModel.seconds == 0 ? 0.5 : 1)
            .padding(.top)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("BG"))
                .ignoresSafeArea()
        }
        
    }
    @ViewBuilder
    func ContextMenuOptions(maxValue: Int, hint: String, onClick: @escaping (Int)->())-> some View {
        ForEach(0...maxValue,id: \.self) {value in
            Button("\(value) \(hint)") {
                onClick(value)
            }
        }
    }
}
    
    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(TimerModel())
        }
    }


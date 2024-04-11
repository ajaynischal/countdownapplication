//
//  TimerModel.swift
//  countdownapplication
//
//  Created by Ajay Nischal(UST,US) on 4/7/24.
//


import SwiftUI

class TimerModel: NSObject, ObservableObject {
    //Timer Property
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    //Starting timer
    func startTimer() {
        
    }
    
    func stopTimer() {
        
    }
}

//
//  countdownapplicationApp.swift
//  countdownapplication
//
//  Created by Ajay Nischal(UST,US) on 4/6/24.
//

import SwiftUI

@main
struct countdownapplicationApp: App {
    //Background
    @StateObject var timerModel: TimerModel = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(timerModel)
        }
    }
}

//
//  ContentView.swift
//  countdownapplication
//
//  Created by Ajay Nischal(UST,US) on 4/6/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerModel : TimerModel
    var body: some View {
        Home()
            .environmentObject(TimerModel())
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  TimerModel.swift
//  countdownapplication
//
//  Created by Ajay Nischal(UST,US) on 4/7/24.
//


import SwiftUI

class TimerModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    //Timer Property
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    //Total Seconds
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    //post timer properties
    @Published var isFinished: Bool = false
    
    //NSObject needs override
    override init() {
        super.init()
        self.authorizeNotification()
    }
    //Request Notification Access
    func authorizeNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { _, _ in
        }
        
        //Show in App Notification
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
    
    //Starting timer
    func startTimer() {
        withAnimation(.easeInOut(duration: 0.25)){
            isStarted = true
            //Setting of String time value
            timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)":"0\(minutes)"):\(seconds >= 10 ? "\(seconds)":"0\(seconds)")"
            //Calculating Total Seconds for tiemr animation
            totalSeconds = (hour * 3600) + (minutes * 60) + seconds
            staticTotalSeconds = totalSeconds
            addNewTimer = false
            addNotification()
        }
    }
    
    func stopTimer() {
        withAnimation {
            isStarted = false
            hour = 0
            minutes = 0
            seconds = 0
            progress = 1
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timerStringValue = "00:00"
    }
    
    //Update Timer
    func updateTimer() {
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 :progress)
        // 60 minutes * 60 seconds
        hour = totalSeconds / 3600
        minutes = (totalSeconds / 60) * 60
        seconds = (totalSeconds % 60)
        timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)":"0\(minutes)"):\(seconds >= 10 ? "\(seconds)":"0\(seconds)")"
        if hour == 0 && seconds == 0 {
            isStarted = false
            print("Finished")
            isFinished = true
        }
        
    }
    
    //Notifications
    func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Study Timer"
        content.subtitle = "You did it! Great Job!"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))
        
        UNUserNotificationCenter.current().add(request)
    }
}

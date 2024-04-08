//
//  ContentView.swift
//  Task 1 (Notification)
//
//  Created by Aryan Sharma on 08/04/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var title = ""
    @State private var message = ""
    private let notificationDelegate = NotificationDelegate()

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                VStack {
                    Text("Task 1 (Notification)")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Title", text: $title)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    TextField("Message", text: $message)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Button(action: {
                        sendNotification()
                    }) {
                        Text("Submit")
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }.navigationBarHidden(true)
        }.onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted == true && error == nil {
                    print("Permission granted!")
                } else {
                    print("Permission not granted.")
                }
            }
            UNUserNotificationCenter.current().delegate = notificationDelegate
        })
    }

    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = message
        notificationContent.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let requestIdentifier = "sendNotification"
        let notificationRequest = UNNotificationRequest(identifier: requestIdentifier, content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(notificationRequest) { error in
            if let error = error {
                print("Error sending notification: \(error)")
            } else {
                print("Notification scheduled!")
            }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}


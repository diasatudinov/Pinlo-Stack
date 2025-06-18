//
//  Pinlo_StackApp.swift
//  Pinlo Stack
//
//

import SwiftUI

@main
struct Pinlo_StackApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            PSRoot()
                .preferredColorScheme(.light)
        }
    }
}

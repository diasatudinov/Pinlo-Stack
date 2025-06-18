//
//  SettingsViewModelPS.swift
//  Pinlo Stack
//
//


import SwiftUI

class SettingsViewModelPS: ObservableObject {
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
}

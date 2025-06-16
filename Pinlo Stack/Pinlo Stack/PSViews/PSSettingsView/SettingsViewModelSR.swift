//
//  SettingsViewModelSR.swift
//  Pinlo Stack
//
//


import SwiftUI

class SettingsViewModelSR: ObservableObject {
    @AppStorage("musicEnabled") var musicEnabled: Bool = true
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
}

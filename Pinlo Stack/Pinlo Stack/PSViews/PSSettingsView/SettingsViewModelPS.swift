//
//  SettingsViewModelPS.swift
//  Pinlo Stack
//
//


import SwiftUI

class SettingsViewModelPS: ObservableObject {
    @AppStorage("soundEnabled") var soundEnabled: Bool = true
}

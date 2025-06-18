//
//  PSDeviceInfo.swift
//  Pinlo Stack
//
//


import UIKit

class PSDeviceInfo {
    static let shared = PSDeviceInfo()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}

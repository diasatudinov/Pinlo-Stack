//
//  PSStoreSection.swift
//  Pinlo Stack
//
//


import SwiftUI

enum PSStoreSection: Codable, Hashable {
    case backgrounds
    case ball
}

class PSShopViewModel: ObservableObject {
    @Published var shopTeamItems: [PSItem] = [
        
        PSItem(name: "bg1", image: "gameBg1PS", icon: "backIcon1PS", section: .backgrounds, price: 50),
        PSItem(name: "bg2", image: "gameBg2PS", icon: "backIcon2PS", section: .backgrounds, price: 50),
        PSItem(name: "bg3", image: "gameBg3PS", icon: "backIcon3PS", section: .backgrounds, price: 50),
        PSItem(name: "bg4", image: "gameBg4PS", icon: "backIcon4PS", section: .backgrounds, price: 50),
        PSItem(name: "bg5", image: "gameBg5PS", icon: "backIcon5PS", section: .backgrounds, price: 50),

        
        PSItem(name: "set1", image: "set1", icon: "set1IconPS", section: .ball, price: 100),
        PSItem(name: "set2", image: "set2", icon: "set2IconPS", section: .ball, price: 200),
        PSItem(name: "set3", image: "set3", icon: "set3IconPS", section: .ball, price: 300),
        PSItem(name: "set4", image: "set4", icon: "set4IconPS", section: .ball, price: 400),
        PSItem(name: "set5", image: "set5", icon: "set5IconPS", section: .ball, price: 500),
        PSItem(name: "set6", image: "set6", icon: "set6IconPS", section: .ball, price: 0),
        PSItem(name: "set7", image: "set7", icon: "set7IconPS", section: .ball, price: 0),
        PSItem(name: "set8", image: "set8", icon: "set8IconPS", section: .ball, price: 0),
        PSItem(name: "set9", image: "set9", icon: "set9IconPS", section: .ball, price: 0),
        PSItem(name: "set10", image: "set10", icon: "set10IconPS", section: .ball, price: 0),
    ]
    
    @Published var boughtItems: [PSItem] = [
        PSItem(name: "bg1", image: "gameBg1PS", icon: "backIcon1PS", section: .backgrounds, price: 50),
        PSItem(name: "set1", image: "set1", icon: "set1IconPS", section: .ball, price: 100),
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    @Published var currentBgItem: PSItem? {
        didSet {
            saveCurrentBg()
        }
    }
    
    @Published var currentPersonItem: PSItem? {
        didSet {
            saveCurrentPerson()
        }
    }
    
    init() {
        loadCurrentBg()
        loadCurrentPerson()
        loadBoughtItem()
    }
    
    private let userDefaultsBgKey = "bgKeyPS1"
    private let userDefaultsPersonKey = "skinsKeyPS1"
    private let userDefaultsBoughtKey = "boughtItemsPSNe1"

    
    func saveCurrentBg() {
        if let currentItem = currentBgItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsBgKey)
            }
        }
    }
    
    func loadCurrentBg() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBgKey),
           let loadedItem = try? JSONDecoder().decode(PSItem.self, from: savedData) {
            currentBgItem = loadedItem
        } else {
            currentBgItem = shopTeamItems[0]
            print("No saved data found")
        }
    }
    
    func saveCurrentPerson() {
        if let currentItem = currentPersonItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsPersonKey)
            }
        }
    }
    
    func loadCurrentPerson() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsPersonKey),
           let loadedItem = try? JSONDecoder().decode(PSItem.self, from: savedData) {
            currentPersonItem = loadedItem
        } else {
            currentPersonItem = shopTeamItems[5]
            print("No saved data found")
        }
    }
    
    func saveBoughtItem() {
        if let encodedData = try? JSONEncoder().encode(boughtItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsBoughtKey)
        }
        
    }
    
    func loadBoughtItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBoughtKey),
           let loadedItem = try? JSONDecoder().decode([PSItem].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct PSItem: Codable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var icon: String
    var section: PSStoreSection
    var price: Int
}

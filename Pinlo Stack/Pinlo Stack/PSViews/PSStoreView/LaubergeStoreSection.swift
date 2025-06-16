//
//  LaubergeStoreSection.swift
//  Pinlo Stack
//
//


import SwiftUI

enum LaubergeStoreSection: Codable, Hashable {
    case backgrounds
    case ball
}

class LaubergeShopViewModel: ObservableObject {
    @Published var shopTeamItems: [LaubergeItem] = [
        
        LaubergeItem(name: "bg1", image: "gameBg1PS", icon: "backIcon1PS", section: .backgrounds, price: 50),
        LaubergeItem(name: "bg2", image: "gameBg2PS", icon: "backIcon2PS", section: .backgrounds, price: 50),
        LaubergeItem(name: "bg3", image: "gameBg3PS", icon: "backIcon3PS", section: .backgrounds, price: 50),
        LaubergeItem(name: "bg4", image: "gameBg4PS", icon: "backIcon4PS", section: .backgrounds, price: 50),
        LaubergeItem(name: "bg5", image: "gameBg5PS", icon: "backIcon5PS", section: .backgrounds, price: 50),

        
        LaubergeItem(name: "set1", image: "set1", icon: "set1IconPS", section: .ball, price: 100),
        LaubergeItem(name: "set2", image: "set2", icon: "set2IconPS", section: .ball, price: 200),
        LaubergeItem(name: "set3", image: "set3", icon: "set3IconPS", section: .ball, price: 300),
        LaubergeItem(name: "set4", image: "set4", icon: "set4IconPS", section: .ball, price: 400),
        LaubergeItem(name: "set5", image: "set5", icon: "set5IconPS", section: .ball, price: 500),
        LaubergeItem(name: "set6", image: "set6", icon: "set6IconPS", section: .ball, price: 0),
        LaubergeItem(name: "set7", image: "set7", icon: "set7IconPS", section: .ball, price: 0),
        LaubergeItem(name: "set8", image: "set8", icon: "set8IconPS", section: .ball, price: 0),
        LaubergeItem(name: "set9", image: "set9", icon: "set9IconPS", section: .ball, price: 0),
        LaubergeItem(name: "set10", image: "set10", icon: "set10IconPS", section: .ball, price: 0),
    ]
    
    @Published var boughtItems: [LaubergeItem] = [
        LaubergeItem(name: "bg1", image: "gameBg1PS", icon: "backIcon1PS", section: .backgrounds, price: 50),
        LaubergeItem(name: "set1", image: "set1", icon: "set1IconPS", section: .ball, price: 100),
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    @Published var currentBgItem: LaubergeItem? {
        didSet {
            saveCurrentBg()
        }
    }
    
    @Published var currentPersonItem: LaubergeItem? {
        didSet {
            saveCurrentPerson()
        }
    }
    
    init() {
        loadCurrentBg()
        loadCurrentPerson()
        loadBoughtItem()
    }
    
    private let userDefaultsBgKey = "bgKeyPS"
    private let userDefaultsPersonKey = "skinsKeyPS"
    private let userDefaultsBoughtKey = "boughtItemsPSNe"

    
    func saveCurrentBg() {
        if let currentItem = currentBgItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsBgKey)
            }
        }
    }
    
    func loadCurrentBg() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBgKey),
           let loadedItem = try? JSONDecoder().decode(LaubergeItem.self, from: savedData) {
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
           let loadedItem = try? JSONDecoder().decode(LaubergeItem.self, from: savedData) {
            currentPersonItem = loadedItem
        } else {
            currentPersonItem = shopTeamItems[4]
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
           let loadedItem = try? JSONDecoder().decode([LaubergeItem].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct LaubergeItem: Codable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var icon: String
    var section: LaubergeStoreSection
    var price: Int
}

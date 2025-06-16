import SwiftUI

enum LaubergeStoreSection: Codable, Hashable {
    case backgrounds
    case skin
}

class LaubergeShopViewModel: ObservableObject {
    @Published var shopTeamItems: [LaubergeItem] = [
        
        LaubergeItem(name: "bg1", image: "gameBg1Lauberge", icon: "backIcon1Lauberge", section: .backgrounds, price: 100),
        LaubergeItem(name: "bg2", image: "gameBg2Lauberge", icon: "backIcon2Lauberge", section: .backgrounds, price: 100),
        LaubergeItem(name: "bg3", image: "gameBg3Lauberge", icon: "backIcon3Lauberge", section: .backgrounds, price: 100),
        LaubergeItem(name: "bg4", image: "gameBg4Lauberge", icon: "backIcon4Lauberge", section: .backgrounds, price: 100),
        
        
        LaubergeItem(name: "skin1", image: "imageSkin1Lauberge", icon: "iconSkin1Lauberge", section: .skin, price: 100),
        LaubergeItem(name: "skin2", image: "imageSkin2Lauberge", icon: "iconSkin2Lauberge", section: .skin, price: 100),
        LaubergeItem(name: "skin3", image: "imageSkin3Lauberge", icon: "iconSkin3Lauberge", section: .skin, price: 100),
        LaubergeItem(name: "skin4", image: "imageSkin4Lauberge", icon: "iconSkin4Lauberge", section: .skin, price: 100),
         
    ]
    
    @Published var boughtItems: [LaubergeItem] = [
        LaubergeItem(name: "bg1", image: "gameBg1Lauberge", icon: "backIcon1Lauberge", section: .backgrounds, price: 100),
        LaubergeItem(name: "skin1", image: "imageSkin1Lauberge", icon: "iconSkin1Lauberge", section: .skin, price: 100),
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
    
    private let userDefaultsBgKey = "bgKeyLauberge"
    private let userDefaultsPersonKey = "skinsKeyLauberge"
    private let userDefaultsBoughtKey = "boughtItemsLauberge"

    
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
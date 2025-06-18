//
//  SRAchievementsViewModel.swift
//  Pinlo Stack
//
//


import SwiftUI

class PSAchievementsViewModel: ObservableObject {
    
    @Published var achievements: [PSAchievement] = [
        PSAchievement(image: "achievIcon1", isAchieved: false),
        PSAchievement(image: "achievIcon2", isAchieved: false),
        PSAchievement(image: "achievIcon3", isAchieved: false),
        PSAchievement(image: "achievIcon4", isAchieved: false),
        PSAchievement(image: "achievIcon5", isAchieved: false)

    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsAchievementsKey = "achievementsKeyPS"
    
    func achieveToggle(_ achive: PSAchievement) {
        guard let index = achievements.firstIndex(where: { $0.id == achive.id })
        else {
            return
        }
        achievements[index].isAchieved.toggle()
        
    }
    
    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsAchievementsKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsAchievementsKey),
           let loadedItem = try? JSONDecoder().decode([PSAchievement].self, from: savedData) {
            achievements = loadedItem
        } else {
            print("No saved data found")
        }
    }
}

struct PSAchievement: Codable, Hashable, Identifiable {
    var id = UUID()
    var image: String
    var isAchieved: Bool
}

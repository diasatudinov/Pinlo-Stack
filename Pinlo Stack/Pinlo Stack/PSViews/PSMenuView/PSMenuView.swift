//
//  PSMenuView.swift
//  Pinlo Stack
//
//

import SwiftUI

struct PSMenuView: View {
    @State private var showGame = false
    @State private var showAchievement = false
    @State private var showStore = false
    @State private var showSettings = false
    @State private var showDailyTask = false

    @AppStorage("dailyTaskRecieved1") private var dailyTaskRecieved = false
    
    @StateObject var achievementVM = SRAchievementsViewModel()
    @StateObject var settingsVM = SettingsViewModelSR()
    @StateObject var shopVM = LaubergeShopViewModel()
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(.settingsIconPS)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 130:65)
                    }
                    
                    Spacer()
                    
                    CoinBgSR()
                    
                    
                    
                }.padding(.horizontal, 20)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Button {
                        showGame = true
                        
                    } label: {
                        
                        ZStack {
                            Image(.playIconPS)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:146)
                            
                            
                                
                        }
                    }
                    
                    
                    Button {
                        showStore = true
                    } label: {
                        ZStack {
                            Image(.storeIconPS)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:146)
                            
                            
                                
                        }
                    }
                    
                    Button {
                        showDailyTask.toggle()
                    } label: {
                        ZStack {
                            Image(.dailyTaskIconPS)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:146)
                            
                            
                                
                        }
                    }
                    
                    Button {
                        showAchievement = true
                    } label: {
                        ZStack {
                            Image(.achievementIconPS)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:146)
                            
                        }
                    }
                }
                Spacer()
            }
            
            if showDailyTask {
                Color.black.opacity(0.6).ignoresSafeArea()
                ZStack {
                    
                    Image(.dailyTaskBgPS)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        Spacer()
                        
                        Button {
                            showDailyTask.toggle()
                            if !dailyTaskRecieved {
                                dailyTaskRecieved = true
                            }
                        } label: {
                            Image(dailyTaskRecieved ? .recievedBtnPS : .getBtnPS)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 150:100)
                        }
                    }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 750:450)
                    
                }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 700:400)
            }
            
        }
        .background(
            ZStack {
                Image(.appBgPS)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
        .fullScreenCover(isPresented: $showGame) {
            PSLevelChooseView(shopVM: shopVM)
        }
        .fullScreenCover(isPresented: $showStore) {
            PSStoreView(viewModel: shopVM)
        }
        .fullScreenCover(isPresented: $showAchievement) {
            PSAchivementsView(viewModel: achievementVM)
        }
        .fullScreenCover(isPresented: $showSettings) {
            PSSettingsView(settingsVM: settingsVM)
        }
        
        
        
        
    }
    
}

#Preview {
    PSMenuView()
}

//
//  PSAchivementsView.swift
//  Pinlo Stack
//
//

import SwiftUI

struct PSAchivementsView: View {
    @StateObject var user = UserPS.shared
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: PSAchievementsViewModel
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconPS)
                                .resizable()
                                .scaledToFit()
                                .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 150:80)
                        }
                        
                        Spacer()
                        
                        CoinBgPS()
                      
                    }.padding([.top, .horizontal])
                }
                
                Image(.achievementsTextPS)
                    .resizable()
                    .scaledToFit()
                    .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 180:130)
               
                Spacer()
                
                
                VStack(spacing: 15) {
                    ForEach(viewModel.achievements, id: \.self) { achieve in
                        achievementItem(item: achieve)
                    }
                }
               
            }
        }.background(
            ZStack {
                Image(.appBgPS)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
    
    @ViewBuilder func achievementItem(item: PSAchievement) -> some View {
        ZStack {
            
            Image(item.isAchieved ? item.image:"\(item.image)Off")
                .resizable()
                .scaledToFit()
            
            
            
            HStack {
                Spacer()
                Button {
                    if !item.isAchieved {
                        user.updateUserMoney(for: 10)
                    }
                    viewModel.achieveToggle(item)
                    
                } label: {
                    Image(item.isAchieved ? .checkIconPS : .xmarkIconPS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 100:50)
                }
            }.padding(.horizontal, PSDeviceInfo.shared.deviceType == .pad ? 140:40)
        }.frame(height: PSDeviceInfo.shared.deviceType == .pad ? 150:92)
    }
    
}

#Preview {
    PSAchivementsView(viewModel: PSAchievementsViewModel())
}

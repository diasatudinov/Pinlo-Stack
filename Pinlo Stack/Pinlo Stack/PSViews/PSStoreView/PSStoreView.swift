//
//  PSStoreView.swift
//  Pinlo Stack
//
//

import SwiftUI

struct PSStoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = UserSR.shared
    @State var section: LaubergeStoreSection = .ball
    @ObservedObject var viewModel: LaubergeShopViewModel
    @State var skinIndex: Int = 0
    @State var backIndex: Int = 0
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Image(.backIconPS)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 150:80)
                    }
                    
                    Spacer()
                    
                    CoinBgSR()
                    
                }.padding([.horizontal])
                
                HStack {
                    Image(.ballTextPS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 120:70)
                        .offset(y: section == .ball ? 20 : 0)
                        .onTapGesture {
                            withAnimation {
                                section = .ball
                            }
                        }
                    
                    Image(.locationsTextPS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 120:70)
                        .offset(y: section == .backgrounds ? 20 : 0)
                        .onTapGesture {
                            withAnimation {
                                section = .backgrounds
                            }
                        }
                }
                
                Spacer()
                
                if section == .ball {
                    VStack {
                        achievementItem(item: viewModel.shopTeamItems.filter({ $0.section == .ball })[0])
                        
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
                        LazyVGrid(columns: columns, spacing: 30) {
                            ForEach(viewModel.shopTeamItems.filter({ $0.section == .ball }), id: \.self) { item in
                                if item.price/100 != 1 {
                                    achievementItem(item: item)
                                }
                            }
                        }
                        
                    }
                } else {
                    VStack {
                        achievementItem(item: viewModel.shopTeamItems.filter({ $0.section == .backgrounds })[0])
                        
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
                        LazyVGrid(columns: columns, spacing: 30) {
                            ForEach(viewModel.shopTeamItems.filter({ $0.section == .backgrounds }), id: \.self) { item in
                                if item.name != "bg1" {
                                    achievementItem(item: item)
                                }
                            }
                        }
                        
                    }
                }
                
                Spacer()
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
    
    @ViewBuilder func achievementItem(item: LaubergeItem) -> some View {
        
        
        ZStack {
            Image(item.icon)
                .resizable()
                .scaledToFit()
                
            
            if item.section == .ball {
                if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                    VStack {
                        Spacer()
                        ZStack {
                            
                            if let currentItem = viewModel.currentPersonItem, currentItem.name == item.name {
                                Image(.selectedTextPS)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 60:33)
                            } else {
                                Image(.selectTextPS)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 60:33)
                            }
                            
                        }
                    }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:100)
                } else {
                    VStack {
                        Spacer()
                        ZStack {
                            Image(user.money >= item.price ? "price\(item.price)PS" : "price\(item.price)PSOff")
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 60:33)
                            
                        }
                    }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 200:100)
                }
            } else {
                if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                    VStack {
                        Spacer()
                        ZStack {
                            
                            if let currentItem = viewModel.currentBgItem, currentItem.name == item.name {
                                Image(.selectedTextPS)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                            } else {
                                Image(.selectTextPS)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                            }
                            
                        }
                    }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 300:170)
                } else {
                    VStack {
                        Spacer()
                        ZStack {
                            Image(user.money >= item.price ? "price\(item.price)PS" : "price\(item.price)PSOff")
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
                            
                        }
                    }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 300:170)
                }
            }
            
        }.frame(height: item.section == .ball ? SRDeviceInfo.shared.deviceType == .pad ? 200:100 : SRDeviceInfo.shared.deviceType == .pad ? 300:170)
            .onTapGesture {
                if item.section == .ball {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        viewModel.currentPersonItem = item
                    } else {
                        if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            
                            if user.money >= item.price {
                                if item.price != 0 {
                                    user.minusUserMoney(for: item.price)
                                    viewModel.boughtItems.append(item)
                                }
                            }
                        }
                    }
                } else {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        viewModel.currentBgItem = item
                    } else {
                        if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            
                            if user.money >= item.price {
                                user.minusUserMoney(for: item.price)
                                viewModel.boughtItems.append(item)
                            }
                        }
                    }
                }
            }
        
        
    }
    
}

#Preview {
    PSStoreView(viewModel: LaubergeShopViewModel())
}

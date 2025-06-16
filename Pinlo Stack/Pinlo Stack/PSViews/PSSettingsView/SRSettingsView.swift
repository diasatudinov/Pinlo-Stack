//
//  SRSettingsView.swift
//  Pinlo Stack
//
//  Created by Dias Atudinov on 16.06.2025.
//


import SwiftUI

struct PSSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var settingsVM: SettingsViewModelSR
    var body: some View {
        ZStack {
            
            ZStack {
                Image(.settingsBgPS)
                    .resizable()
                    .scaledToFit()
                VStack(spacing: 15) {
                    
                    Spacer()
                    VStack(spacing: 5) {
                        Image(.soundsTextPS)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 60:36)
                        
                        HStack {
                            Image(.offTextPS)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 40:24)
                            
                            Button {
                                withAnimation {
                                    settingsVM.soundEnabled.toggle()
                                }
                            } label: {
                                
                                Image(settingsVM.soundEnabled ? .onPS:.offPS)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 80:44)
                            }
                            
                            Image(.onTextPS)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 40:24)
                        }
                    }
                    
                    VStack(spacing: 5) {
                        Image(.lamguageTextPS)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 60:36)
                        
                        Image(.languageIconPS)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 80:44)
                    }
                    
                    Image(.resetBtnPS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 160:80)
                    
                }.padding(.bottom, 30)
                
            }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 750:420)
            
            VStack {
                HStack {
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
                    }.padding([.horizontal, .top])
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
}

#Preview {
    PSSettingsView(settingsVM: SettingsViewModelSR())
}

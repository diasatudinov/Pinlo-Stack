//
//  ContentView.swift
//  Pinlo Stack
//
//


import SwiftUI

struct PSGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var gameWon = false
    @ObservedObject var shopVM: PSShopViewModel
    
    @State var gameScene: PSGameScene = {
        let scene = PSGameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    var body: some View {
        ZStack {
            
            
            VStack(spacing: 0) {
                SRViewContainer(scene: gameScene).ignoresSafeArea()
                
                Spacer()
            }
            
            VStack {
                
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
                    
                    
                }.padding([.horizontal])
                
                Spacer()
                HStack {
                    Image(.bonus1PS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 130:80)
                    
                    Image(.bonus2PS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 130:80)
                }
                
                HStack {
                    Image(.bonus3PS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 130:80)
                    
                    Image(.bonus4PS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 130:80)
                    
                    Image(.bonus5PS)
                        .resizable()
                        .scaledToFit()
                        .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 130:80)
                }
            }
            
            if gameWon {
                ZStack {
                    Image(.gameWinBgPS)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.homeIconPS)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 170:100)
                            }
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.restartIconPS)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 170:100)
                            }
                        }
                    }.padding(.bottom, PSDeviceInfo.shared.deviceType == .pad ? 80:50)
                }.frame(height: PSDeviceInfo.shared.deviceType == .pad ? 700:400)
            }
            
            
        }.background(
            ZStack {
                if let bgImage = shopVM.currentBgItem {
                    Image("\(bgImage.image)")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                }
                
            }
        )
        .onReceive(NotificationCenter.default.publisher(for: .gameWon)) { _ in
            gameWon = true
            UserPS.shared.updateUserMoney(for: 10)
        }
    }
}

#Preview {
    PSGameView(shopVM: PSShopViewModel())
}

extension Notification.Name {
    static let gameWon = Notification.Name("gameWon")
}

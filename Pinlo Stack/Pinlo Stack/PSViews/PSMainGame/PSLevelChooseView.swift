//
//  PSLevelChooseView.swift
//  Pinlo Stack
//
//

import SwiftUI

struct PSLevelChooseView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = UserPS.shared
    @ObservedObject var shopVM: PSShopViewModel
    @State var currentIndex: Int?
    @State var showGame = false
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
                
                Image(.levelSelectPS)
                    .resizable()
                    .scaledToFit()
                    .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 240:131)
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 5)
                
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(Range(0...29)) { index in
                                ZStack {
                                    Image(.levelNumBgPS)
                                        .resizable()
                                        .scaledToFit()
                                    Text("\(index + 1)")
                                        .font(.system(size: PSDeviceInfo.shared.deviceType == .pad ? 70:39))
                                        .foregroundStyle(.yellow)
                                   
                                }.frame(height: PSDeviceInfo.shared.deviceType == .pad ? 120:60)
                                    .onTapGesture {
                                        showGame = true
                                        DispatchQueue.main.async {
                                            currentIndex = index
                                        }
                                    }
                            }
                        }
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
        .fullScreenCover(isPresented: $showGame) {
            if let currentIndex = currentIndex {
                PSGameView(shopVM: shopVM)
            }
        }
        
    }
}

#Preview {
    PSLevelChooseView(shopVM: PSShopViewModel())
}

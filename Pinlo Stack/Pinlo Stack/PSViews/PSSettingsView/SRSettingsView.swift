import SwiftUI

struct SRSettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var settingsVM: SettingsViewModelSR
    var body: some View {
        ZStack {
            
            ZStack {
                Image(.settingsBgSR)
                    .resizable()
                    .scaledToFit()
                VStack(alignment: .leading, spacing: 30) {
                    
                    HStack(spacing: 30) {
                        
                        Image(.soundsTextSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 60:31)
                        Button {
                            withAnimation {
                                settingsVM.soundEnabled.toggle()
                            }
                        } label: {
                            
                            Image(settingsVM.soundEnabled ? .onSR:.offSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 80:44)
                        }
                        
                    }
                    
                    HStack(spacing: 50) {
                        Image(.musicTextSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 60:31)
                        
                        Button {
                            withAnimation {
                                settingsVM.musicEnabled.toggle()
                            }
                        } label: {
                            
                            Image(settingsVM.musicEnabled ? .onSR:.offSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 80:44)
                        }
                        
                    }
                    
                }
                
            }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 800:400)
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconSR)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 150:75)
                        }
                        Spacer()
                       
                        Image(.settingsTextSR)
                            .resizable()
                            .scaledToFit()
                        
                        Spacer()
                        Image(.backIconSR)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SRDeviceInfo.shared.deviceType == .pad ? 150:75)
                            .opacity(0)
                    }.padding([.horizontal, .top])
                }
                Spacer()
            }
        }.background(
            ZStack {
                Image(.appBgSR)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
}

#Preview {
    SRSettingsView(settingsVM: SettingsViewModelSR())
}
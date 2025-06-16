import SwiftUI

struct CoinBgSR: View {
    @StateObject var user = UserSR.shared
    var body: some View {
        ZStack {
            Image(.moneyViewBgSR)
                .resizable()
                .scaledToFit()
            
            Text("\(user.money)")
                .font(.system(size: SRDeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black))
                .foregroundStyle(.white)
                .textCase(.uppercase)
                .offset(x: SRDeviceInfo.shared.deviceType == .pad ? 10:5, y: SRDeviceInfo.shared.deviceType == .pad ? 0:0)
            
            
            
        }.frame(height: SRDeviceInfo.shared.deviceType == .pad ? 100:50)
        
    }
}

#Preview {
    CoinBgSR()
}

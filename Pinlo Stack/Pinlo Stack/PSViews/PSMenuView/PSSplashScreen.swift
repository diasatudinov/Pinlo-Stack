//
//  PSSplashScreen.swift
//  Pinlo Stack
//
//

import SwiftUI

struct PSSplashScreen: View {
    @State private var scale: CGFloat = 1.0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    private var loaderWidth: CGFloat = {
       return PSDeviceInfo.shared.deviceType == .pad ? 500:250
    }()
    var body: some View {
        ZStack {
            Image(.loaderBgPS)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                ZStack {
                    Image(.loaderBallPS)
                        .resizable()
                        .scaledToFit()
                    
                    
                }
                .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 250:149)
                
                
                Image(.loadingTextPS)
                    .resizable()
                    .scaledToFit()
                    .frame(height: PSDeviceInfo.shared.deviceType == .pad ? 120:64)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: scale
                    )
                    .onAppear {
                        scale = 0.8
                    }
                    .padding(.vertical, 20)
                
               
                
                
                Spacer()
            }
            
            
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    PSSplashScreen()
}

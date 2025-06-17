//
//  ContentView.swift
//  Pinlo Stack
//
//


import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var gameWon = false
   
    
    @State var gameScene: GameScene = {
        
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    var body: some View {
        ZStack {
            SRViewContainer(scene: gameScene).ignoresSafeArea()
            
            VStack {
             
            }
        }
    }
}

#Preview {
    ContentView()
}

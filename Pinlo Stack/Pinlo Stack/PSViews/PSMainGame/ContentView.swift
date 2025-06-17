import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel()

    var body: some View {
        VStack {
            Text("Sort the Balls!")
                .font(.largeTitle)
                .padding()

            Grid(horizontalSpacing: 20, verticalSpacing: 20) {
                ForEach(Array(viewModel.shelves.enumerated()), id: \.offset) { index, shelf in
                    GridRow {
                        VStack {
                            ForEach(shelf) { ball in
                                Circle()
                                    .fill(Color(ball.color.uiColor))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Circle().stroke(viewModel.selectedBall?.ball.id == ball.id ? Color.black : Color.clear, lineWidth: 3)
                                    )
                            }
                        }
                        .frame(width: 50, height: 200)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .onTapGesture {
                            viewModel.selectBall(from: index)
                        }
                    }
                }
            }

            if viewModel.isGameWon {
                Text("🎉 You Won! 🎉")
                    .font(.title)
                    .padding()
            }

            Button("Restart") {
                viewModel.resetGame()
            }
            .padding()
        }
    }
}
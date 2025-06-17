class GameViewModel: ObservableObject {
    @Published var shelves: [[Ball]] = []
    @Published var selectedBall: (shelfIndex: Int, ball: Ball)? = nil

    let maxShelfSize = 4
    let shelfCount = 8

    init() {
        resetGame()
    }

    func resetGame() {
        shelves = Array(repeating: [], count: shelfCount)
        // Заполняем случайно шарами всех цветов
        var allBalls: [Ball] = []
        for color in BallColor.allCases {
            allBalls += Array(repeating: Ball(color: color), count: maxShelfSize)
        }
        allBalls.shuffle()

        for i in 0..<shelfCount {
            shelves[i] = Array(allBalls.prefix(maxShelfSize))
            allBalls.removeFirst(maxShelfSize)
        }

        selectedBall = nil
    }

    func selectBall(from shelfIndex: Int) {
        guard !shelves[shelfIndex].isEmpty else { return }
        if let selected = selectedBall {
            moveBall(to: shelfIndex)
        } else {
            let topBall = shelves[shelfIndex].last!
            selectedBall = (shelfIndex: shelfIndex, ball: topBall)
        }
    }

    func moveBall(to shelfIndex: Int) {
        guard let selected = selectedBall else { return }
        guard shelfIndex != selected.shelfIndex else {
            // Нажал на ту же полку — снять выделение
            selectedBall = nil
            return
        }

        // Проверка по правилам — например, только одинаковые или пустая полка
        if let targetTop = shelves[shelfIndex].last {
            if targetTop.color != selected.ball.color {
                // Запретить разные цвета
                return
            }
        }

        if shelves[shelfIndex].count >= maxShelfSize {
            // Полка заполнена
            return
        }

        // Удалить с исходной
        shelves[selected.shelfIndex].removeLast()

        // Добавить на целевую
        shelves[shelfIndex].append(selected.ball)

        selectedBall = nil

        // Проверка на сборку 4 шариков одного цвета
        checkShelfCompletion(shelfIndex)
    }

    func checkShelfCompletion(_ shelfIndex: Int) {
        guard shelves[shelfIndex].count == maxShelfSize else { return }

        let color = shelves[shelfIndex][0].color
        if shelves[shelfIndex].allSatisfy({ $0.color == color }) {
            // Очистить полку с анимацией можно через delay или withAnimation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    self.shelves[shelfIndex].removeAll()
                }
            }
        }
    }

    var isGameWon: Bool {
        shelves.allSatisfy { $0.isEmpty }
    }
}
//
//  BallColor.swift
//  Pinlo Stack
//
//


import SpriteKit

class GameScene: SKScene {
    
    let shopVM = LaubergeShopViewModel()
    
    // 1) Определяем все возможные цвета и соответствующие им имена PNG в Assets
    enum BallColor: String, CaseIterable {
        case red, blue, green, yellow, purple, orange, pink, cyan
        var imageName: String { "\(rawValue)_ball" }
    }
    
    struct Shelf {
        let node: SKSpriteNode
        var balls: [SKSpriteNode]
    }
    
    private var shelves: [Shelf] = []
    private var selected: [SKSpriteNode] = []
    // 2) Выбираем 3 случайных цвета из 8 при инициализации
    private lazy var gameColors: [BallColor] = {
        Array(BallColor.allCases.shuffled().prefix(3))
    }()
    
    override func didMove(to view: SKView) {
        scaleMode = .resizeFill
        backgroundColor = .clear
        setupShelves()
        setupBalls()
    }
    
    private func setupShelves() {
        let names = ["shelf_right", "shelf_left","shelf_right" , "shelf_left" ]
        let total = names.count
        let spacingY = (frame.height) / CGFloat(total + 1)
        for (i, name) in names.enumerated() {
            let sprite = SKSpriteNode(imageNamed: name)
            sprite.size = CGSize(width: 207, height: 43)
            sprite.position = CGPoint(
                x: (i % 2 == 1)
                ? frame.minX + sprite.size.width/2
                : frame.maxX - sprite.size.width/2,
                y: frame.maxY - spacingY * CGFloat(i + 1)
            )
            addChild(sprite)
            shelves.append(Shelf(node: sprite, balls: []))
        }
    }
    
    private func setupBalls() {
        // 3) Создаём по 4 шарика для каждого из трёх выбранных цветов
        var allBalls: [SKSpriteNode] = []
        guard let currentBall = shopVM.currentPersonItem else { return }
        for color in gameColors {
            for _ in 0..<4 {
                let ball = SKSpriteNode(imageNamed: "\(currentBall.image)\(color.imageName)")
                ball.name = color.rawValue           // ← имя цвета: "red", "blue", "green" :contentReference[oaicite:5]{index=5}
                ball.size = CGSize(width: 36, height: 36)
                ball.zPosition = 1
                allBalls.append(ball)
            }
        }
        allBalls.shuffle()
        
        // 4) Случайно распределяем 12 шариков по 4 полкам (каждая 1…4 штук, в сумме 12)
        var counts: [Int]
        repeat {
            counts = (0..<shelves.count).map { _ in Int.random(in: 1...4) }
        } while counts.reduce(0, +) != allBalls.count
        
        var idx = 0
        for (shelfIndex, count) in counts.enumerated() {
            let shelfNode = shelves[shelfIndex].node
            let startX = -CGFloat(count - 1) * 25  // шаг 50px
            let shelfHalfH = shelfNode.size.height / 2
            for j in 0..<count {
                let ball = allBalls[idx]; idx += 1
                shelves[shelfIndex].balls.append(ball)
                // Располагаем горизонтально под полкой
                ball.position = CGPoint(
                    x: shelfNode.position.x + startX + CGFloat(j) * 50,
                    y: shelfNode.position.y + shelfHalfH + 10
                )
                addChild(ball)
            }
        }
    }
    
    // MARK: — касания для выделения группы шариков одного цвета
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        clearSelection()  // очищаем массив и возвращаем alpha в 1.0 для ранее выделенных шариков :contentReference[oaicite:0]{index=0}
        
        guard let touch = touches.first else { return }  // работаем с одним касанием :contentReference[oaicite:1]{index=1}
        let loc = touch.location(in: self)
        
        guard let ball = nodes(at: loc)                     // получаем все узлы в точке касания :contentReference[oaicite:2]{index=2}
            .compactMap({ $0 as? SKSpriteNode })  // фильтруем только спрайты :contentReference[oaicite:3]{index=3}
            .first else { return }
        
        guard let ballName = ball.name else { return }
        
        for shelf in shelves {
            if let start = shelf.balls.firstIndex(of: ball) {
                // Собираем подряд идущие шарики того же цвета
                var idx = start
                while idx < shelf.balls.count && shelf.balls[idx].name == ballName {
                    selected.append(shelf.balls[idx])  // добавляем в выделенный массив :contentReference[oaicite:5]{index=5}
                    idx += 1
                }
                break
            }
        }
        
        // Визуально отмечаем выделенные шарики
        selected.forEach { $0.alpha = 0.6 }  // полупрозрачность для подсветки :contentReference[oaicite:6]{index=6}
    }
    
    // MARK: — отпускаем и переносим
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Если нет выделенных шариков или нет касания — выходим
        guard !selected.isEmpty, let touch = touches.first else { return }
        let loc = touch.location(in: self)
        
        // Находим индекс полки с ближайшей к точке отпуска Y-координатой
        guard let tIdx = shelves.enumerated()
            .min(by: { abs($0.element.node.position.y - loc.y)
                < abs($1.element.node.position.y - loc.y) })?.offset
        else {
            clearSelection()
            return
        }
        
        // Вычисляем, сколько шариков можно переместить (макс 4 на полке)
        let capacity = shelves[tIdx].balls.count
        let movable = min(selected.count, max(4 - capacity, 0))
        guard movable > 0 else {
            clearSelection()
            return
        }
        
        // Переносим те шарики, которые помещаются
        let movingBalls = selected.prefix(movable)
        movingBalls.forEach { ball in
            // Удаляем из всех полок
            for i in shelves.indices {
                shelves[i].balls.removeAll(where: { $0 == ball })
            }
            // Добавляем на целевую полку
            shelves[tIdx].balls.append(ball)
        }
        
        
        // Обновляем расположение шариков на всех полках
        for i in shelves.indices {
            layoutShelf(at: i)
        }
        
        // Сбрасываем выделение
        clearSelection()
        
        // Если на полке 4 шарика одного цвета — запускаем анимацию исчезновения и очищаем массив
        let shelfBalls = shelves[tIdx].balls
        if shelfBalls.count == 4,
           let firstName = shelfBalls.first?.name,
           shelfBalls.allSatisfy({ $0.name == firstName }) {
            
            let fade   = SKAction.fadeOut(withDuration: 0.3)
            let remove = SKAction.removeFromParent()
            let seq    = SKAction.sequence([fade, remove])
            
            shelfBalls.forEach { ball in
                ball.run(seq)
            }
            shelves[tIdx].balls.removeAll()
        }
        
        if shelves[tIdx].balls.count == 0 {
            // Тут уже удалена последняя группа из 4 шариков,
            // но нужно проверить все полки:
            let allEmpty = shelves.allSatisfy { $0.balls.isEmpty }
            if allEmpty {
                NotificationCenter.default.post(name: .gameWon, object: nil)
            }
        }
    }
    
    private func layoutShelf(at idx: Int) {
        let shelf = shelves[idx]
        let cnt = shelf.balls.count
        let startX = -CGFloat(cnt - 1) * 25
        let baseY = shelf.node.position.y + shelf.node.size.height/2 + 10
        for (i, ball) in shelf.balls.enumerated() {
            let target = CGPoint(
                x: shelf.node.position.x + startX + CGFloat(i) * 50,
                y: baseY
            )
            ball.run(.move(to: target, duration: 0.2))
        }
    }
    
    private func clearSelection() {
        selected.forEach { $0.alpha = 1.0 }
        selected.removeAll()
    }
}

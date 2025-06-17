import Foundation

enum BallColor: CaseIterable {
    case red, blue, green, yellow, purple, orange, pink, cyan

    var uiColor: UIColor {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        case .yellow: return .yellow
        case .purple: return .purple
        case .orange: return .orange
        case .pink: return .systemPink
        case .cyan: return .cyan
        }
    }
}

struct Ball: Identifiable {
    let id = UUID()
    let color: BallColor
}
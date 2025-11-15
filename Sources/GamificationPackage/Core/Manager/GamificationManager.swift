public final class GamificationManager {
    public static let shared = GamificationManager()

    // The app sets this
    public var onEvent: ((GamificationEvent) -> Void)?

    private init() {}
}

public enum GamificationEvent {
    case rewardClaimed(id: String)
    case buttonTapped(name: String)
    case levelCompleted(level: Int)
}

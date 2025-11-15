import Foundation

public struct GamificationConfig {
    public let baseURL: String
    public let tokenProvider: () -> String?
    
    public init(
        baseURL: String,
        tokenProvider: @escaping () -> String?
    ) {
        self.baseURL = baseURL
        self.tokenProvider = tokenProvider
    }
}

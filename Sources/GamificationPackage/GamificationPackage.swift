// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI

public struct GamificationPackage : Sendable {

    public init(config: GamificationConfig) async {
        FontRegistrar.registerAllFonts()
        await GamificationAPIManager.shared.configure(config)
    }

    @MainActor public func dashboard() -> some View {
        GamificationDashBoardView(router: Router())
    }
}

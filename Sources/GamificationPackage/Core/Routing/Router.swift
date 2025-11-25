//
//  Router.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


import SwiftUI
import Combine

internal final class Router: ObservableObject {
    @Published var popup: Route?

    @MainActor
    func presentPopup(_ route: Route) {
        popup = route
    }

    @MainActor
    func dismissPopup() {
        popup = nil
    }
    
    @MainActor
    func swapPopup(_ newRoute: Route, delay: Double = 0.3) {
        dismissPopup()
        Task {
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            await MainActor.run {
                presentPopup(newRoute)
            }
        }
    }
}

//
//  Router.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


import SwiftUI
import Combine

final class Router: ObservableObject {
    @Published var popup: Route?

    @MainActor
    func presentPopup(_ route: Route) {
        popup = route
    }

    @MainActor
    func dismissPopup() {
        popup = nil
    }
}

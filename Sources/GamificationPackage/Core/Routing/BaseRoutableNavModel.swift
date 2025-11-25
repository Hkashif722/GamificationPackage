//
//  BaseRoutableNavModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


import SwiftUI
import Combine

@MainActor
class BaseRoutableNavModel: ObservableObject {
    
    // Every ViewModel gets the router injected
    internal let router: Router
    
    // Event publisher reference
    let eventPublisher = GamificationEventPublisher.shared

    init(router: Router) {
        self.router = router
    }

    // Forward router operations

    func presentPopup(_ route: Route) {
        router.presentPopup(route)
    }

    func dismissPopup() {
        router.dismissPopup()
    }
}

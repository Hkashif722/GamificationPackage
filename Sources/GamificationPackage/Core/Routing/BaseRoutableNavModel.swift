//
//  BaseRoutableNavModel.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 15/11/25.
//


import SwiftUI
import Combine

class BaseRoutableNavModel: ObservableObject {
    
    // Every ViewModel gets the router injected
    internal let router: Router

    init(router: Router) {
        self.router = router
    }

    // Forward router operations
    @MainActor
    func presentPopup(_ route: PopupRoute) {
        router.presentPopup(route)
    }

    @MainActor
    func dismissPopup() {
        router.dismissPopup()
    }
}

//
//  GamificationDashBoardView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 29/10/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationDashBoardView: View {
    
    @ObservedObject var router: Router
    
    @StateObject var gmDashBoardViewModel: GamificationDashboardViewModel
    
    init(router: Router) {
        self.router = router
        _gmDashBoardViewModel = StateObject(
            wrappedValue: GamificationDashboardViewModel(router: router)
        )
    }
    
    var body: some View {
        ZStack {
            
            // Blur when popup is active
            content
                .blur(radius: router.popup != nil ? 8 : 0)
                .animation(.easeInOut, value: router.popup)
            
            // Popup presentation
            if let popup = router.popup {
                gmDashBoardViewModel.popupView(popup)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.85).combined(with: .opacity),
                        removal: .scale(scale: 0.85).combined(with: .opacity)
                    ))
            }
        }
        .animation(
            .spring(response: 0.35, dampingFraction: 0.75),
            value: router.popup
        )
        .fullSize()
        .ignoresSafeArea()
    }
    
    // Dashboard content grouped so blur applies smoothly
    private var content: some View {
        ZStack {
            GamificationDashboardBackgroundView()
            GamificationDashboardClubClanInfoView(router: router)
            GamificationDashboardNavControlView()
            GamificationDashboardProfileItemsView()
            GamificationDashboardScoreView(score: gmDashBoardViewModel.myRankingResponseModel?.totalPoint)
            GamificationDashboardCentralMenuItemDeck(onAction: gmDashBoardViewModel.presentPopupView(_:))
        }
        .task {
            await gmDashBoardViewModel.allApiCall()
        }
    }

}

//
//  GamificationDashBoardView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 29/10/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationDashBoardView: View {
    
    var body: some View {
        
        ZStack {
            GamificationDashboardBackgroundView()
            GamificationDashboardClubClanInfoView()
            GamificationDashboardNavControlView()
            GamificationDashboardProfileItemsView()
            GamificationDashboardScoreView()
            GamificationDashboardCentralMenuItemDeck(onAction: { _ in })
            
        }
        .fullSize()
        
    }
    
   
}

#Preview {
    GamificationDashBoardView()
}

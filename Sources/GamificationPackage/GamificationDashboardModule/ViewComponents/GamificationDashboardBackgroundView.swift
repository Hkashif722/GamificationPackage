//
//  GamificationDashboardBackgroundView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 30/10/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationDashboardBackgroundView: View {
    
    var body: some View {
        ZStack {
            gamificationBackgroundImage
        }
    }
    
    private var gamificationBackgroundImage: some View {
        SwiftUIUtility.BackgroundImageView(
            imageName: GamificationClubTypeDataModel.shared.clubType.dashboardBackground,
            contentMode: .fill
        )
    }
}   


#Preview {
    GamificationDashboardBackgroundView()
}


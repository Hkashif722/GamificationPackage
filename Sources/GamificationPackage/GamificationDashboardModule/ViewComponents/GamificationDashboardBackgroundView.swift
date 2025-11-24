//
//  GamificationDashboardBackgroundView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 30/10/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationDashboardBackgroundView: View {
    
    @ObservedObject private var clubTypeModel = GamificationClubTypeDataModel.shared
    
    var body: some View {
        GeometryReader { geometry in
            gamificationBackgroundImage
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
        }
        .ignoresSafeArea()
    }
    
    private var gamificationBackgroundImage: some View {
        SwiftUIUtility.BackgroundImageView(
            imageName: clubTypeModel.clubType.dashboardBackground,
            contentMode: .fill
        )
    }
}

#Preview {
    GamificationDashboardBackgroundView()
}

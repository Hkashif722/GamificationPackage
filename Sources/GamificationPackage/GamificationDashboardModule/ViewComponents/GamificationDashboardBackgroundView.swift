//
//  GamificationDashboardBackgroundView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 30/10/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationDashboardBackgroundView: View {
    
    var body: some View {
        ZStack {
            gamificationBackgroundImage
        }
    }
    
    private var gamificationBackgroundImage: some View {
        SwiftUIUtility.BackgroundImageView(
            imageName: "gm_Knight Club_bg",
            contentMode: .fill
        )
    }
}   


#Preview {
    GamificationDashboardBackgroundView()
}


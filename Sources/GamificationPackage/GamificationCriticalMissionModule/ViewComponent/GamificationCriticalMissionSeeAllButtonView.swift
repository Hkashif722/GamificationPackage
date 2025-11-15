//
//  GamificationCriticalMissionSeeAllButtonView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationCriticalMissionSeeAllButtonView: View {
    
    var body: some View {
        seeAllButtonView
    }
    
    private var seeAllButtonView: some View {
        SwiftUIUtility.RectangularGradientButton(
            title: "See All",
            gradient: LinearGradient(
                colors: [
                    Color(hex: "#192F3A"),
                    Color(hex: "#06C2C4")
                ],
                startPoint: .top,
                endPoint: .bottom
            ),
            foregroundColor: .white,
            borderColor: Color(hex: "#06C2C4"),
            height: 35,
            action: { }
        )
        .frame(width: 150, height: 35)
    }
}

#Preview {
    GamificationCriticalMissionSeeAllButtonView()
}

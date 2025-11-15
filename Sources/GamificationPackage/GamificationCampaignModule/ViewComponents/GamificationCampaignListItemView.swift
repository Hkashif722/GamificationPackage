//
//  GamificationCampaignListItemView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignListItemView: View {
    
    let onClick: () -> ()
    
    var body: some View {
        
        HStack(spacing: 16) {
            campaignNameView
            campaignPointView
            playButtonView
        }
        .foregroundStyle(.white)
    }
    
    private var campaignNameView: some View {
        Text("Camp C01")
            .appFont(.poppinsSemiBold, size: 14, weight: .semibold)
    }
    
    private var campaignPointView: some View {
        Text("Course Reward Point: 100")
            .appFont(.poppinsRegular, size: 14)
            .frame(maxWidth: .infinity)
    }

    
    private var playButtonView: some View {
        SwiftUIUtility.RectangularGradientButton(
            title: "Play",
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
            height: 30,
            action: onClick
        )
        .frame(width: 90, height: 30)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        GamificationCampaignListItemView(onClick: {})
    }
}

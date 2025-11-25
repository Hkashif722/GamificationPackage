//
//  GamificationCampaignBottomControlView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignBottomControlView: View {
    
    let paginationText: String
    let hasPrevious: Bool
    let hasNext: Bool
    let onPreviousClick: () -> Void
    let onNextClick: () -> Void
    
    let bottomDescriptionText: String = "Complete the above course during the campaign and earn bonus reward points!"
    
    
    var body: some View {
        HStack(spacing: 16) {
            bottomInfoView
            paginationContentView
        }
        .padding(.init(top: 8, leading: 10, bottom: 8, trailing: 10))
    }
    
    private var bottomInfoView: some View {
        Text(bottomDescriptionText)
            .appFont(.poppinsRegular, size: 13)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var paginationContentView: some View {
        HStack(spacing: 8) {
            controlBackButtonView(iconName: "chevron.left", isEnabled: hasPrevious, onClick: onPreviousClick)
            paginationView
            controlBackButtonView(iconName: "chevron.right", isEnabled: hasNext, onClick: onNextClick)
        }
    }
    
    private var paginationView: some View {
        Text(paginationText)
            .foregroundStyle(.white)
            .appFont(.poppinsSemiBold, size: 14, weight: .semibold)
    }
    
}


//MARK: Utility
extension GamificationCampaignBottomControlView {
    
    private func controlBackButtonView(iconName: String, isEnabled: Bool, onClick: @escaping () -> ()) -> some View {
        
        SwiftUIUtility.RectangularGradientButton(
            iconName: iconName,
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
        .frame(width: 45)
        .disabledWithOpacity(!isEnabled)
    }
    
}


#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        GamificationCampaignBottomControlView(
            paginationText: "1-3 / 10",
            hasPrevious: false,
            hasNext: true,
            onPreviousClick: {},
            onNextClick: {}
        )
    }
}

//
//  CampaignHeaderControlView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignHeaderControlView: View {
    
    var body: some View {
        
        VStack {
            campaignHeaderControlView
            SwiftUIUtility.GradientDivider()
        }
        .padding(.top, 8)
        
    }
    
    
    private var campaignHeaderControlView: some View {
        HStack(spacing: 16) {
            controlBackButtonView(iconName: "chevron.left", onClick: {})
            headerInfoView
            controlBackButtonView(iconName: "chevron.right", onClick: {})
        }
    }
    
    
    private var headerInfoView: some View {
        VStack {
            campaignNameView
            campaignDateRangView
        }
    }
    
    private var campaignNameView: some View {
        Text("1.2025-Camp C01 ")
            .appFont(.poppinsSemiBold, size: 18, weight: .semibold)
            .foregroundStyle(Color(hex: "#00F1D8"))
    }
    
    private var campaignDateRangView: some View {
        Text("(Apr 28,2025- Apr 30,2025)")
            .appFont(.poppinsRegular, size: 14)
            .foregroundStyle(.white)
    }

}


//MARK: Utility
extension GamificationCampaignHeaderControlView {
    
    private func controlBackButtonView(iconName: String, onClick: @escaping () -> ()) -> some View {
        
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
    }
    
}

#Preview {
    GamificationCampaignHeaderControlView()
}

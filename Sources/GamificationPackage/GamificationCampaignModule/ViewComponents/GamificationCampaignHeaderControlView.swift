//
//  CampaignHeaderControlView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignHeaderControlView: View {
    
    let campaignModel: GamificationDashboardDataModel.GroupedCampaign?
    let hasPrevious: Bool
    let hasNext: Bool
    let onPreviousClick: () -> ()
    let onNextClick: () -> ()
    
    var body: some View {
        
        VStack {
            campaignHeaderControlView
            SwiftUIUtility.GradientDivider()
        }
        .padding(.top, 8)
        
    }
    
    
    private var campaignHeaderControlView: some View {
        HStack(spacing: 16) {
            controlBackButtonView(iconName: "chevron.left", onClick: onPreviousClick)
                .disabledWithOpacity(!hasPrevious)
            headerInfoView
            controlBackButtonView(iconName: "chevron.right", onClick: onNextClick)
                .disabledWithOpacity(!hasNext)
        }
    }
    
    
    private var headerInfoView: some View {
        VStack {
            campaignNameView
            campaignDateRangView
        }
    }
    
    private var campaignNameView: some View {
        Text(campaignModel?.name ?? "")
            .appFont(.poppinsSemiBold, size: 18, weight: .semibold)
            .foregroundStyle(Color(hex: "#00F1D8"))
    }
    
    @ViewBuilder
    private var campaignDateRangView: some View {
        if let startDate = campaignModel?.startDate, let endDate = campaignModel?.endDate {
            Text("\(startDate) - \(endDate)")
                .appFont(.poppinsRegular, size: 14)
                .foregroundStyle(.white)
        }
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
    GamificationCampaignHeaderControlView(
        campaignModel: .previewSingle,
        hasPrevious: true,
        hasNext: true,
        onPreviousClick: {},
        onNextClick: {}
    )
}

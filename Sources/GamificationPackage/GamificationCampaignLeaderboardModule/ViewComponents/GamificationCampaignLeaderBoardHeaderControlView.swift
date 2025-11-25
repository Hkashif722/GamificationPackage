//
//  GamificationCampaignLeaderBoardHeaderControlView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import SwiftUI

struct GamificationCampaignLeaderBoardHeaderControlView: View {
    
    let campaignLeaderUserData: GamificationCampaignLeaderboardDataModel.CampaignLeaderboardSingleUserData?
    let hasPrevious: Bool
    let hasNext: Bool
    let onPreviousClick: () -> ()
    let onNextClick: () -> ()
    
    var body: some View {
        
        VStack {
            campaignHeaderControlView
        }
        .padding(.top, 8)
        .padding(.horizontal, 30)
        
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
        .frame(maxWidth: .infinity)
    }
    
    private var campaignNameView: some View {
        Text(campaignLeaderUserData?.campaignName ?? "")
            .appFont(.poppinsSemiBold, size: 18, weight: .semibold)
            .foregroundStyle(Color(hex: "#00F1D8"))
            .minimumScaleFactor(0.8)
    }
    
    @ViewBuilder
    private var campaignDateRangView: some View {
        if let safeStartDate = campaignLeaderUserData?.startDate, let safeEndDate = campaignLeaderUserData?.endDate {
            Text("\(safeStartDate) - \(safeEndDate)")
                .appFont(.poppinsRegular, size: 14)
                .foregroundStyle(.white)
        }
    }

}


//MARK: Utility
extension GamificationCampaignLeaderBoardHeaderControlView {
    
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
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationCampaignLeaderBoardHeaderControlView(
            campaignLeaderUserData: GamificationCampaignLeaderboardDataModel.previewCampaignLeaderboardSingleUserData,
            hasPrevious: true,
            hasNext: true,
            onPreviousClick: {},
            onNextClick: {}
        )
    }
}



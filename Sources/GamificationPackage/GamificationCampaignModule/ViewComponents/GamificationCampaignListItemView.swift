//
//  GamificationCampaignListItemView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignListItemView: View {
    
    let course: GamificationDashboardDataModel.GroupedCampaign.Course
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
        Text(course.title)
            .appFont(.poppinsSemiBold, size: 14, weight: .semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var campaignPointView: some View {
        Text("Course Reward Point: \(course.rewardPoints)")
            .appFont(.poppinsRegular, size: 14)
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
        GamificationCampaignListItemView(
            course: GamificationDashboardDataModel.GroupedCampaign.Course(
                id: 1,
                code: "Camp C01",
                title: "Test Course",
                rewardPoints: 100
            ),
            onClick: {}
        )
    }
}

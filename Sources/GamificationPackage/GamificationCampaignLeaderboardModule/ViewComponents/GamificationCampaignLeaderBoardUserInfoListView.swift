//
//  GamificationCampaignLeaderBoardUserInfoListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignLeaderBoardUserInfoListView: View {
    
    let campaignLeaderboardModel: [GamificationCampaignLeaderboardDataModel.CampaignLeaderboardData]
    
    var body: some View {
        gamificationLeaderboardUserInfoListView
    }
    
    private var gamificationLeaderboardUserInfoListView: some View {
        ScrollView {
            ForEach(Array(campaignLeaderboardModel.enumerated()), id: \.offset) { index, model in
                GamificationCampaignLeaderBoardUserInfoListItemView(index: index, campaignLeaderboardModel: model)
            }
        }
        .versionedContentMargins()
        .applyScrollBounceBehavior()
    }
}


struct GamificationCampaignLeaderBoardUserInfoListView_Preview: View{
    init() {
        FontRegistrar.registerAllFonts()
    }
    var body: some View{
        ZStack {
            GamificationDashboardBackgroundView()
                .blur(radius: 4)
            GamificationCampaignLeaderBoardUserInfoListView(
                campaignLeaderboardModel: GamificationCampaignLeaderboardDataModel.previewCampaignLeaderboardData
            )
        }
    }
}

#Preview {
    GamificationCampaignLeaderBoardUserInfoListView_Preview()
}


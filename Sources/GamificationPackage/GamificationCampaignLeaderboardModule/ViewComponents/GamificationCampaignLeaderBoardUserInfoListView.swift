//
//  GamificationCampaignLeaderBoardUserInfoListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignLeaderBoardUserInfoListView: View {
    
//    let topRanking: [GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking]
    
    var body: some View {
        gamificationLeaderboardUserInfoListView
    }
    
    private var gamificationLeaderboardUserInfoListView: some View {
        ScrollView {
            ForEach(0..<10) { index in
                GamificationCampaignLeaderBoardUserInfoListItemView(index: index + 1)
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
            GamificationCampaignLeaderBoardUserInfoListView()
        }
    }
}

#Preview {
    GamificationCampaignLeaderBoardUserInfoListView_Preview()
}


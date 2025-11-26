//
//  GamificationLeaderboardUserInfoListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationLeaderboardUserInfoListView: View {
    
    let topRanking: [GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking]
    
    var body: some View {
        gamificationLeaderboardUserInfoListView
    }
    
    private var gamificationLeaderboardUserInfoListView: some View {
        ScrollView {
            ForEach(Array(topRanking.enumerated()), id: \.element.id) { index, rank in
                GamificationLeaderboardUserInfoListItemView(index: index + 4, rank: rank)
            }
        }
        .versionedContentMargins()
        .applyScrollBounceBehavior()
    }
}

#Preview {
    GamificationLeaderboardUserInfoListView(
        topRanking: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking.previewArray
    )
}

//
//  GamificationLeaderboardView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 05/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationLeaderboardView: View {
    
    let router: Router
    let myRanking: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking?
    let topRanking: [GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack(alignment: .topTrailing) {
                containerGroupView
            }
            .center()
            .ignoresSafeArea()
        }
    }
    
    
    private var containerGroupView: some View {
        VStack(spacing: 16) {
            GamificationLeaderboardTitleView(myRanking: myRanking)
            leaderBoardContentView
        }
        .padding(.init(top: 10, leading: 0, bottom: 36, trailing: 0))
    }
    
    
    private var leaderBoardContentView: some View {
        
        VStack(spacing: 0) {
            
            LeaderBoardStageProfileView(topRanking: topRanking)
            
            Divider()
                .background(Color(hex: "#334082"))
            
            GamificationLeaderboardUserInfoListView(topRanking: topRanking)
                .padding(.horizontal, 10)
        }
        .background(
            leaderBoardContainerView
        )
        .frame(maxWidth: 450)
    }
    
    private var leaderBoardContainerView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.clear)
            .frostedGlass(overlayOpacity: 0.7)
    }
    
    
    private var closeButtonView: some View {
        Button(action: router.dismissPopup ) {
            Image("ic_gm_close", bundle: .module)
                .frame(width: 45, height: 45)
        }
        .padding()
    }

}


#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
            
        GamificationLeaderboardView(
            router: Router(),
            myRanking: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking.preview,
            topRanking: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking.previewArray
        )
    }
}

//
//  GamificationLeaderboardTitleView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationLeaderboardTitleView: View {
    
    let myRanking: GamificationDashboardDataModel.LeaderBoardResponseModel.Ranking?
    
    var body: some View {
        ZStack(alignment: .trailing) {
            userProfileInfoView
            ZStack {
                headerTitleView
            }
            .frame(width: 450)
        }
    }
    
    
    private var headerTitleView: some View {
        Text("LEADERBOARD")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
            
    }
    

    private var userProfileInfoView: some View {
        HStack {
            userProfileView
            userInfoView
        }
    }
    
    
    
    private var userProfileView: some View {
        SwiftUIUtility.ProfileImageViewWithVariableCorner(
            imageUrl: myRanking?.fullProfilePath ?? URL(string: ""),
            size: 45, cornerRadius: 10,
            profileBorderColor: .white
        )
    }
   
    
    
    private var userInfoView: some View {
        VStack(alignment: .leading) {
            userNameView
            userPointView
        }
    }
    
    
    private var userNameView: some View {
        Text(myRanking?.userName ?? "Undefined")
            .appFont(.poppinsRegular, size: 14)
            .foregroundStyle(.white)
    }
    
    private var userPointView: some View {
        Text(myRanking?.totalPoint.description ?? "Undefined")
            .appFont(.poppinsBold, size: 14, weight: .bold)
            .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        
        Color.purple
            .ignoresSafeArea()
        
        GamificationLeaderboardTitleView(myRanking: .preview)
        
    }
}

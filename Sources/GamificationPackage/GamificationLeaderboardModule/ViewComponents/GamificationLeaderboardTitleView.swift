//
//  GamificationLeaderboardTitleView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationLeaderboardTitleView: View {
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            headerTitleView
            userProfileInfoView
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
            imageUrl: URL(string:""),
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
        Text("LMS Admin")
            .appFont(.poppinsRegular, size: 14)
            .foregroundStyle(.white)
    }
    
    private var userPointView: some View {
        Text("7999")
            .appFont(.poppinsBold, size: 14, weight: .bold)
            .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        
        Color.purple
            .ignoresSafeArea()
        
        GamificationLeaderboardTitleView()
        
    }
}

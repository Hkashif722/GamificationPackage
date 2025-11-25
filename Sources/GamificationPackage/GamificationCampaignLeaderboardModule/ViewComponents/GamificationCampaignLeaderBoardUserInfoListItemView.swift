//
//  GamificationCampaignLeaderBoardUserInfoListItemView.swift
//  SWAYAM 2.0 copy
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignLeaderBoardUserInfoListItemView: View {
    
    let index: Int
    let campaignLeaderboardModel: GamificationCampaignLeaderboardDataModel.CampaignLeaderboardData
    
    var body: some View {
        HStack(spacing: 16) {
            rankView
            profileInfoView
            userPointView
        }
        .foregroundColor(.white)
    }
    
    private var rankView: some View {
        Text("\(String(format: "%02d", index))")
            .appFont(.poppinsRegular, size: 14)
            .foregroundColor(.white)
            .frame(width: 40, alignment: .leading)
    }
    

    private var profileInfoView: some View {
        HStack(spacing: 8) {
            profilePictureView
            userNameView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var profilePictureView: some View {
        SwiftUIUtility.ProfileImageView(
            imageUrl: campaignLeaderboardModel.computedUseProlePictureURL,
            size: 25,
            profileBorderColor: .white
        )
        .appFont(.poppinsRegular, size: 14)
        .frame(width: 40, alignment: .leading)
    }
    
    private var userNameView: some View {
        Text(campaignLeaderboardModel.userName ?? "")
            .appFont(.poppinsRegular, size: 14)
            .frame(alignment: .leading)
    }
    
    
    private var userPointView: some View {
        Text("\(campaignLeaderboardModel.campaignRewardPoints ?? 0)")
        .appFont(.poppinsSemiBold, size: 14)
        .foregroundColor(.white)
    }
}

#Preview {
    GamificationCampaignLeaderBoardUserInfoListItemView(
        index: 1,
        campaignLeaderboardModel: GamificationCampaignLeaderboardDataModel.previewCampaignLeaderboardData[0],
    )
    .background(Color.black)
}

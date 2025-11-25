//
//  GamificationCampaignLeaderBoardHeaderProfileInfoView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//


import SwiftUI

internal struct GamificationCampaignLeaderBoardHeaderProfileInfoView: View {
    
    @ObservedObject var clubLevelViewModel = GamificationClubTypeDataModel.shared
    let campaignLeaderUserData: GamificationCampaignLeaderboardDataModel.CampaignLeaderboardSingleUserData?
    
    var body: some View {
        HStack {
            userInfoViewWithProfilePicture
            yourRankInfoView
        }
    }
    
    
    private var userInfoViewWithProfilePicture: some View {
        HStack(alignment: .top, spacing: 16) {
            profilePictureView
            userInfoView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var userInfoView: some View {
        VStack(alignment: .leading,spacing: 0) {
            userNameView
            earnedRewardPointView
        }
    }
}

extension GamificationCampaignLeaderBoardHeaderProfileInfoView {
    
    private var profilePictureView: some View {
        SwiftUIUtility.ProfileImageViewWithVariableCorner(
            imageUrl: clubLevelViewModel.userProfileDetail?.computedUseProlePictureURL,
            size: 40,
            cornerRadius: 10,
            profileBorderColor: .white
        )
    }
    
    private var userNameView: some View {
        Text(campaignLeaderUserData?.userName ?? "")
            .appFont(.poppinsSemiBold, size: 18, weight: .semibold)
            .foregroundStyle(.white)
    }
    
    private var earnedRewardPointView: some View {
        Text("Earned Rewards Points - \(campaignLeaderUserData?.campaignRewardPoints ?? 0)")
            .appFont(.poppinsRegular, size: 14, weight: .regular)
            .foregroundStyle(.white)
    }
    
    private var yourRankInfoView: some View {
        Text("Your Rank \(campaignLeaderUserData?.campaignRank ?? 0)")
            .appFont(.poppinsBold, size: 18, weight: .bold)
            .foregroundStyle(.black)
            .padding(.init(top: 4, leading: 12, bottom: 4, trailing: 12))
            .reusableGradientBackground(
                stops: [
                    .init(color: Color(hex:"#FFFEC5 "), location: 0.0),
                    .init(color: Color(hex:"#BECA39"), location: 1.0),
                ]
            )
            .background (
                Capsule().stroke()
            )
            .clipShape(Capsule())
    }
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationCampaignLeaderBoardHeaderProfileInfoView(
            campaignLeaderUserData: GamificationCampaignLeaderboardDataModel.previewCampaignLeaderBoardResponse.aPIGetCampaignLeaderboardSingleUserData
        )
        
    }
}

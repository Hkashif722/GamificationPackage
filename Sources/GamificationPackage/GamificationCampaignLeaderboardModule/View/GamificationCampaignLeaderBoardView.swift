//
//  GamificationCampaignLeaderBoardView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 25/11/25.
//

import SwiftUI

struct GamificationCampaignLeaderBoardView: View {
    
    @StateObject private var campaignLeaderboardViewModel: GamificationCampaignLeaderboardViewModel
    
    init(router: Router) {
        _campaignLeaderboardViewModel = StateObject(
            wrappedValue: GamificationCampaignLeaderboardViewModel(router: router)
        )
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                if campaignLeaderboardViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                } else {
                    gamificationCampaignLeaderBoardView
                }
            }
            .center()
            .ignoresSafeArea()
        }
        .task {
            await campaignLeaderboardViewModel.getCampaignApplicabilityRequestModel()
        }
    }
    
    private var gamificationCampaignLeaderBoardView: some View {
        VStack(spacing: 8) {
            campaignLeaderBoardTitleView
            VStack(spacing: 4) {
                GamificationCampaignLeaderBoardHeaderProfileInfoView(
                    campaignLeaderUserData: campaignLeaderboardViewModel.campaignUserDataMode
                )
                GamificationCampaignLeaderBoardHeaderControlView(
                    campaignLeaderUserData: campaignLeaderboardViewModel.campaignUserDataMode,
                    hasPrevious: campaignLeaderboardViewModel.hasPrevious,
                    hasNext: campaignLeaderboardViewModel.hasNext,
                    onPreviousClick:campaignLeaderboardViewModel.goToPreviousCampaign,
                    onNextClick: campaignLeaderboardViewModel.goToNextCampaign
                )
                SwiftUIUtility.GradientDivider()
                GamificationCampaignLeaderBoardUserInfoListView()
            }
            .padding()
            .background { backgroundFrostView }
        }
        .frame(maxWidth: 600)
        .padding(.vertical, 20)
    }
}

extension GamificationCampaignLeaderBoardView {
    private var closeButtonView: some View {
        Button(action: campaignLeaderboardViewModel.dismissPopup) {
            Image("ic_gm_close", bundle: .module)
                .frame(width: 45, height: 45)
        }
        .padding()
    }
    
    private var backgroundFrostView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.clear)
            .frostedGlass(overlayOpacity: 0.7)
    }
    
    private var campaignLeaderBoardTitleView: some View {
        Text("CAMPAIGN LEARERBOARD")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
    }
}



struct GamificationCampaignLeaderBoardView_Preview: View{
    init() {
        FontRegistrar.registerAllFonts()
    }
    var body: some View{
        ZStack {
            GamificationDashboardBackgroundView()
                .blur(radius: 4)
            GamificationCampaignLeaderBoardView(router: Router())
        }
    }
}

#Preview {
    GamificationCampaignLeaderBoardView_Preview()
}

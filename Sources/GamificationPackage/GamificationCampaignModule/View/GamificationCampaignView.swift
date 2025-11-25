//
//  GamificationCampaignView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampaignView: View {
    
    @StateObject private var campaignViewModel: GamificationCampaignViewModel
    
    init(router: Router, campaignCourseData: [GamificationDashboardDataModel.GroupedCampaign]) {
        _campaignViewModel = StateObject(
            wrappedValue: GamificationCampaignViewModel(router: router, campaignCourseData: campaignCourseData)
        )
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                gamificationCampaignView
            }
            .center()
            .ignoresSafeArea()
        }
    }
    
    private var gamificationCampaignView: some View {
        VStack(spacing: 8) {
            campaignTitleView
            VStack {
                GamificationCampaignHeaderControlView(
                    campaignModel: campaignViewModel.getCurrentCampaign,
                    hasPrevious: campaignViewModel.hasPreviousPage,
                    hasNext: campaignViewModel.hasNextPage,
                    onPreviousClick: campaignViewModel.previousPage,
                    onNextClick: campaignViewModel.nextPage
                )
                GamificationCampagnListView(
                    courses: campaignViewModel.paginatedCourses,
                    onCourseClick: campaignViewModel.onCourseClick
                )
                SwiftUIUtility.GradientDivider()
                GamificationCampaignBottomControlView(
                    paginationText: campaignViewModel.coursePaginationText,
                    hasPrevious: campaignViewModel.hasPreviousCoursePage,
                    hasNext: campaignViewModel.hasNextCoursePage,
                    onPreviousClick: campaignViewModel.previousCoursePage,
                    onNextClick: campaignViewModel.nextCoursePage
                )
            }
            .background { backgroundFrostView }
        }
        .frame(maxWidth: 480)
        .padding(.vertical, 20)
    }
    
    private var closeButtonView: some View {
        Button(action: campaignViewModel.dismissPopup) {
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
    
    private var campaignTitleView: some View {
        Text("CAMPAIGNS")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
    }
    
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationCampaignView(
            router: Router(),
            campaignCourseData: GamificationDashboardDataModel.GroupedCampaign.previewCampaigns
        )
    }
}

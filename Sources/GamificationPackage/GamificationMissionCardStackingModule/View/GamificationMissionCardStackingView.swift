//
//  GamificationMissionCardStackingView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionCardStackingView: View {
    
    @StateObject private var missionCardViewModel: GamificationMissionCardViewModel
    
    init(router: Router, mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) {
       _missionCardViewModel = StateObject(
        wrappedValue: GamificationMissionCardViewModel(
            router: router,
            mission: mission
        )
       )
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                gamificationMissionCardStackingView
                GamificationMisionCardStackingViewAllButtonView(
                    onClickViewAll: missionCardViewModel.handleViewAll
                )
            }
            .center()
            .ignoresSafeArea()
        }
    }
    
    
    private var gamificationMissionCardStackingView: some View {
        VStack(spacing: 12) {
            missionTitleView
            GamificationMisionCardStackingListView(
                mission: missionCardViewModel.mission,
                onClickLaunch: missionCardViewModel.handleOnLaunchMission(_:)
            )
        }
        .padding()
        .frame(maxWidth: 800, maxHeight: 350)
    }
    
    
    private var missionTitleView: some View {
        Text("MISSIONS")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
        
    }
    
    private var closeButtonView: some View {
        Button(action: missionCardViewModel.dismissPopup) {
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
        GamificationMissionCardStackingView(
            router: Router(),
            mission: .miniMission(
                model: .init(
                    totalMiniMission: 3,
                    totalBossMission: 2,
                    totalNormalMission: 5,
                    completedMiniMission: 1,
                    completedBossMission: 0,
                    completedNormalMission: 2
                ),
                courses: GamificationMissionTypeDataModel.PreviewData.sampleCourses
            )
        )
    }
}

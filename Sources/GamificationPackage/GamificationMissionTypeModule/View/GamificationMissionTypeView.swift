//
//  GamificationMissionTypeView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionTypeView: View {
    
    @StateObject var missionTypeViewModel: GamificationMissionTypeViewModel
    
    init(router: Router, missionCounts: GamificationDashboardDataModel.GamificationMissionResponseModel) {
        _missionTypeViewModel = StateObject(
            wrappedValue: GamificationMissionTypeViewModel(router: router, missionCount: missionCounts)
        )
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                gamificationMissionTypeView
            }
            .center()
            .ignoresSafeArea()
        }
        .task {
            await missionTypeViewModel.fetchAllMissionData()
        }
    }
    
    
    private var gamificationMissionTypeView: some View {
        VStack(spacing: 8) {
            messionTitleView
            GamificationMissionTypeCardListView(
                missions: missionTypeViewModel.missions,
                onPlayCLick: missionTypeViewModel.handleMissionPlay(_:)
            )
        }
        .padding(.bottom)
    }
    
    private var messionTitleView: some View {
        Text("Mission")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
            .padding(.top)
    }
    
    private var closeButtonView: some View {
        Button(action: missionTypeViewModel.dismissPopup) {
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
        GamificationMissionTypeView(
            router: Router(),
            missionCounts: GamificationDashboardDataModel.GamificationMissionResponseModel(
                totalMiniMission: 5,
                totalBossMission: 3,
                totalNormalMission: 10,
                completedMiniMission: 2,
                completedBossMission: 1,
                completedNormalMission: 5
            )
        )
    }
}

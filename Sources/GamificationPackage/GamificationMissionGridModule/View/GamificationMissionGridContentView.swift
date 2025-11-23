//
//  GamificationMissionGridView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionGridContentView: View {
    
    @StateObject private var missionGridViewModel: GamificationMissionGridViewModel
    
    init(router: Router, mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) {
       _missionGridViewModel = StateObject(
        wrappedValue: GamificationMissionGridViewModel(
            router: router,
            mission: mission
        )
       )
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            messionTitleView
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .topTrailing) {
                    closeButtonView
                    ZStack {
                        gamificationMissionGridContentView
                    }
                    .center()
                    .ignoresSafeArea()
                    
                }
                bottomControlView
            }
        }
        
    }
    
    private var gamificationMissionGridContentView: some View {
        VStack(spacing: 8) {
//            messionTitleView
            GamificationMissionGridView(courses: missionGridViewModel.currentPageCourses)
            
        }
        .padding(.init(top: 40, leading: 10, bottom: 0, trailing: 25))
        .scaleEffect(x: 0.9)
    }
    
    private var bottomControlView: some View {
        GamificationMissionGridBottomControlView(
            paginationText: missionGridViewModel.paginationText,
            canGoToPrevious: missionGridViewModel.canGoToPrevious,
            canGoToNext: missionGridViewModel.canGoToNext,
            onPrevious:missionGridViewModel.goToPreviousPage,
            onNext: missionGridViewModel.goToNextPage
        )
        .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 30))
    }
    
    
    private var messionTitleView: some View {
        Text("Mission")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
            .padding(.top, 30)
    }
    
    private var closeButtonView: some View {
        Button(action: missionGridViewModel.dismissPopup) {
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
        GamificationMissionGridContentView(
            router: Router(),
            mission: .miniMission(
                model: .default,
                courses: GamificationMissionTypeDataModel.PreviewData.sampleCourses
            )
        )
    }
    .fullSize()
    .ignoresSafeArea()
}

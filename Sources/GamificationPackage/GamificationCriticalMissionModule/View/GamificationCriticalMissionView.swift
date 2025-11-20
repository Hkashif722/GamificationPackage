//
//  GamificationCriticalMissionView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationCriticalMissionView: View {
    
    @StateObject private var criticalMissionViewModel: GamificationCriticalMissionViewModel
    
    init(router: Router) {
       _criticalMissionViewModel = StateObject(
        wrappedValue: GamificationCriticalMissionViewModel(router: router)
       )
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                gamificationCriticalMissionView
               
            }
            .center()
            .ignoresSafeArea()
        }
        .task {
            await criticalMissionViewModel.getCriticalMissions()
        }
    }
    
    
    private var gamificationCriticalMissionView: some View {
        VStack(spacing: 8) {
            messionTitleView
            GamificationCriticalMissionListView(
                todosModel: criticalMissionViewModel.criticalMissions,
                didSelectViewClub: {},
                didSelectSeeAll: {}
            )
        }
        
    }
    
    
    private var messionTitleView: some View {
        Text("Mission")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
            .padding(.top)
    }
    
    private var closeButtonView: some View {
        Button(action: criticalMissionViewModel.dismissPopup) {
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
        GamificationCriticalMissionView(router: Router())
    }
}

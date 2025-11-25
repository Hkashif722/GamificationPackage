//
//  GamificationAccomplishmentView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationAccomplishmentView: View {
    
    @StateObject private var accomplishmentViewModel: GamificationAccomplishmentViewModel
    
    init(
        router: Router,
        navModel: GamificationAccomplishementDataModel.AccomplishmentNavDataModel
    ) {
        _accomplishmentViewModel = StateObject(
            wrappedValue: GamificationAccomplishmentViewModel(
                router: router,
                navModel: navModel
            )
        )
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                gamificationAccomplishmentView
            }
            .center()
            .ignoresSafeArea()
        }
        
    }
    
    private var gamificationAccomplishmentView: some View {
        VStack {
            GamificationAccomplishmentHeaderView(
                myRankingModel: accomplishmentViewModel.navModel.myRankingModel
            )
            GamificationAccomplishmentListView(missionItems: accomplishmentViewModel.missionItems)
        }
        .frame(maxWidth: 480)
        .background { backgroundFrostView }
        .padding(.vertical, 30)
    }
    
    
    private var backgroundFrostView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.clear)
            .frostedGlass(overlayOpacity: 0.7)
    }
    
    private var closeButtonView: some View {
        Button(action: accomplishmentViewModel.dismissPopup) {
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
        GamificationAccomplishmentView(
            router: Router(),
            navModel: .init(
                missionCountModel: .default,
                myRankingModel: .preview
            )
        )
    }
}

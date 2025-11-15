//
//  GamificationMissionCardStackingView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionCardStackingView: View {
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                gamificationMissionCardStackingView
            }
            .center()
            .ignoresSafeArea()
        }
    }
    
    
    private var gamificationMissionCardStackingView: some View {
        VStack(spacing: 12) {
            missionTitleView
            GamificationMisionCardStackingListView()
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
        Button(action: { }) {
            Image("ic_gm_close")
                .frame(width: 45, height: 45)
        }
        .padding()
    }
    
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationMissionCardStackingView()
    }
}

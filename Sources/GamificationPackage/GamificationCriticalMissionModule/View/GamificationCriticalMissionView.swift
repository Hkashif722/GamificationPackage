//
//  GamificationCriticalMissionView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCriticalMissionView: View {
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                gamificationCriticalMissionView
               
            }
            .center()
            .ignoresSafeArea()
        }
    }
    
    
    private var gamificationCriticalMissionView: some View {
        VStack(spacing: 8) {
            messionTitleView
            GamificationCriticalMissionListView()
        }
        
    }
    
    
    private var messionTitleView: some View {
        Text("Mission")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
            .padding(.top)
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
        GamificationCriticalMissionView()
    }
}

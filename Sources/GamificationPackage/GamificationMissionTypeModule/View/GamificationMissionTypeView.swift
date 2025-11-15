//
//  GamificationMissionTypeView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionTypeView: View {
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                gamificationMissionTypeView
            }
            .center()
            .ignoresSafeArea()
        }
    }
    
    
    private var gamificationMissionTypeView: some View {
        VStack(spacing: 8) {
            messionTitleView
            GamificationMissionTypeCardListView()
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
        Button(action: { }) {
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
        GamificationMissionTypeView()
    }
}

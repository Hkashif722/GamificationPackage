//
//  GamificationMissionGridView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionGridContentView: View {
    
    init() {
        FontRegistrar.registerAllFonts()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            messionTitleView
            ZStack(alignment: .topTrailing) {
                closeButtonView
                ZStack {
                    gamificationMissionGridContentView
                }
                .center()
                .ignoresSafeArea() 
            }
        }
        
    }
    
    private var gamificationMissionGridContentView: some View {
        VStack(spacing: 8) {
//            messionTitleView
            GamificationMissionGridView()
            GamificationMissionGridBottomControlView()
        }
        .padding(.init(top: 40, leading: 10, bottom: 0, trailing: 25))
    }
    
    
    private var messionTitleView: some View {
        Text("Mission")
            .appFont(.quanticoBold, size: 24, weight: .bold)
            .foregroundStyle(.white)
            .padding(.top, 30)
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
        GamificationMissionGridContentView()
    }
}

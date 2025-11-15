//
//  GamificationDashboardNavControlView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//


///---------------------------------` Gamification Nav Control Items`-------------------------------------------------
///-------------------------------------------------
///-------------------------------------------------


import SwiftUI

struct GamificationDashboardNavControlView: View {
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            navigationControlBackgroundView
            navControlButtonViews
        }
        .topTrailing()
        .offset(y: 35)
        .ignoresSafeArea()
        
        
    }
    
    
    private var navigationControlBackgroundView: some View {
        Image("gamification_nav_control_bg")
            .resizable()
            .frame(width: 190, height: 60)
    }
    
    private var navControlButtonViews: some View {
        HStack {
            captureButtonView
            settingButtonView
            closeButtonView
        }
        .padding(.horizontal, 10)
        .offset(y: -3.2)
    }
    
    private var captureButtonView: some View {
        Button(action: {}) {
            Image("ic_gm_capture")
                .frame(width: 45, height: 45)
        }
    }
    
    private var settingButtonView: some View {
        Button(action: {}) {
            Image("ic_gm_setting")
                .frame(width: 45, height: 45)
        }
    }
    
    private var closeButtonView: some View {
        Button(action: {}) {
            Image("ic_gm_setting")
                .frame(width: 45, height: 45)
        }
    }
}


#Preview {
    GamificationDashboardNavControlView()
}



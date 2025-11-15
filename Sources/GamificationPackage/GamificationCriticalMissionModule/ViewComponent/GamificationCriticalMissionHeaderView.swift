//
//  GamificationCriticalMissionHeaderView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCriticalMissionHeaderView: View {
    var body: some View {
        criticalMissionHeaderContentView
    }
    
    private var criticalMissionHeaderContentView: some View {
        criticalMissionHeaderView
    }
    
    
    private var criticalMissionHeaderView: some View {
        VStack {
            messionTitleView
            gradientDivider
        }
    }
    private var messionTitleView: some View {
        Text("CRITICAL MISSIONS (To Do)")
            .appFont(.quanticoBold, size: 18, weight: .bold)
            .foregroundStyle(.white)
    }
    
    private var gradientDivider: some View {
        SwiftUIUtility.GradientDivider()
    }
}

#Preview {
    GamificationCriticalMissionHeaderView()
}

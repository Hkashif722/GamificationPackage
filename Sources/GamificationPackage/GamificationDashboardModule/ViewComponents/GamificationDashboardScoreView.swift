//
//  GamificationDashboardScoreView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationDashboardScoreView: View {
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            scoreBackGroundView
            scoreView
        }
        .bottomTrailing()
        .ignoresSafeArea(edges: .trailing)
        
    }
    
    
    
    private var scoreBackGroundView: some View {
        Image("gm_db_points_bg")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
        
    }
    
    
    private var scoreView: some View {
        VStack(spacing: 2) {
            scoreLableView
            scoreInfoView
        }
        .foregroundStyle(.white)
        .offset(x: -80)
    }
    
    private var scoreLableView: some View {
        Text("SCORE")
            .appFont(.poppinsBold, size: 12, weight: .bold)
    }
    
    private var scoreInfoView: some View {
        Text("2,52,104")
            .appFont(.poppinsBold, size: 20, weight: .bold)
    }
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
        GamificationDashboardScoreView()
    }
}

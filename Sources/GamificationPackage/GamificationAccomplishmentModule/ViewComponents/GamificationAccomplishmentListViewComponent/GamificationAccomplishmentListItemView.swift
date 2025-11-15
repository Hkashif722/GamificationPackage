//
//  GamificationAccomplishmentListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationAccomplishmentListItemView: View {
    
    var body: some View {
        
        HStack(spacing: 16) {
            starIconView
            missionTitle
            dividerView
            missionCompletionInfo
        }
        .foregroundStyle(.white)
    }
    
    
    private var starIconView: some View {
        Image("gm_accomplishment_star_icon")
            .resizable()
            .scaledToFit()
            .frame(width: 45, height: 45)
    }

    private var missionTitle: some View {
        Text("Accomplished Mini Missions")
            .appFont(.poppinsSemiBold, size: 18, weight: .semibold)
            .minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var missionCompletionInfo: some View {
        Text("Past 7 days total: \(00)")
            .appFont(.poppinsMedium, size: 14, weight: .medium)
    }
    
    private var dividerView: some View {
        SwiftUIUtility.GradientDivider(height: 10)
            .frame(width: 2)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        GamificationAccomplishmentListItemView()
    }
}

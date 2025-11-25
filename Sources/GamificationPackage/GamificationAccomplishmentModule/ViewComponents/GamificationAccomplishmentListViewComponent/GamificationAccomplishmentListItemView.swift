//
//  GamificationAccomplishmentListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationAccomplishmentListItemView: View {
    
    let title: String
    let completed: Int
    let total: Int
    
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
        Image("gm_accomplishment_star_icon", bundle: .module)
            .resizable()
            .scaledToFit()
            .frame(width: 45, height: 45)
    }

    private var missionTitle: some View {
        Text(title)
            .appFont(.poppinsSemiBold, size: 18, weight: .semibold)
            .minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var missionCompletionInfo: some View {
        Text("Past 7 days total: \(completed)/\(total)")
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
        GamificationAccomplishmentListItemView(
            title: "Accomplished Mini Missions",
            completed: 5,
            total: 10
        )
    }
}

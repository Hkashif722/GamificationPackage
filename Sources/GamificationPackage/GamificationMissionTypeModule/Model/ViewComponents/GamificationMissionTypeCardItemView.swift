//
//  GamificationMissionTypeCardItemView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionTypeCardItemView: View {
    
    let missionTypeModel: GamificationMissionTypeDataModel.MissionTypeProgressEnum
    
    var body: some View {
        HStack(spacing: 16) {
            progressView
            missionInfoView
            playButtonView
        }
        
    }
    
    private var progressView: some View {
        SwiftUIUtility.CircularProgressView(
            progress: 0.7,
            gradientColors: missionTypeModel.getGradientColors,
            size: 60,
            textColor: .white
        )
    }
    
    private var missionInfoView: some View {
        // MARK: - Texts
        VStack(alignment: .leading, spacing: 6) {
            missionTitle
            missionCompletionStatusView
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
    }
    
    private var missionTitle: some View {
        Text(missionTypeModel.rawValue)
            .appFont(.poppinsSemiBold, size: 18, weight: .semibold)
    }
    
    private var missionCompletionStatusView: some View {
        Text("COMPLETED: 0/6")
            .appFont(.poppinsMedium, size: 18)
            .foregroundColor(.white.opacity(0.8))
    }
    
    private var playButtonView: some View {
        SwiftUIUtility.RectangularIconButtonWithBorder(
            title: "Play",
            foregroundColor: .white,
            borderColor: Color(hex: "#06C2C4"),
            height: 45,
            action: { }
        )
        .frame(width: 150, height: 45)
         
    }
    
    
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        GamificationMissionTypeCardItemView(missionTypeModel: .bossMission)
    }
    
}



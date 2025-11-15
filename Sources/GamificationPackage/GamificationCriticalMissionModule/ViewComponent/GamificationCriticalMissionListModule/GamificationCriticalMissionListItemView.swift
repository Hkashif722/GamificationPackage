//
//  GamificationCriticalMissionListItemView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 10/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCriticalMissionListItemView: View {
    
    var body: some View {
        
        HStack {
            missionInfoView
            Spacer()
            viewClubViewButton
        }
        
    }
    
    
    
    private var missionInfoView: some View {
        VStack(alignment: .leading) {
            missionTitleView
            missionCategoryView
        }
    }
    private var missionTitleView: some View {
        Text("Critical Thinking")
            .appFont(.poppinsSemiBold, size: 14, weight: .semibold)
    }
    
    private var missionCategoryView: some View {
        Text("Mission Category: Course")
            .appFont(.poppinsRegular, size: 14)
    }
    
    private var viewClubViewButton: some View {
        SwiftUIUtility.RectangularIconButtonWithBorder(
            title: "View Club",
            foregroundColor: Color(hex: "#00d6c0"),
            borderColor: Color(hex: "#00d6c0"),
            height: 35
        ) {
            
        }
        .frame(width: 130, height: 35)
    }
}

#Preview {
    GamificationCriticalMissionListItemView()
}

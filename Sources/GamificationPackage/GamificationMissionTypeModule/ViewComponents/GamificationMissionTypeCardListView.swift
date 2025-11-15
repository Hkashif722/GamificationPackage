//
//  GamificationMissionTypeCardListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionTypeCardListView: View {
    var body: some View {
        VStack {
            missionTypeCardListView
        }
        .frame(width: 450)
        .padding()
        .background {
            backgroundFrostView
        }
    }
    
    
    private var missionTypeCardListView: some View {
        
        VStack(spacing: 18) {
            ForEach(
                GamificationMissionTypeDataModel.MissionTypeProgressEnum.allCases
            ) { mission in
                
                GamificationMissionTypeCardItemView(missionTypeModel: mission)
                
                divider(missionType: mission)
                
            }
        }
    }
    
    @ViewBuilder
    private func divider(
        missionType: GamificationMissionTypeDataModel.MissionTypeProgressEnum
    ) -> some View {
        if missionType != .bossMission {
            Divider()
                .background(.white)
        }
    }
    
    private var backgroundFrostView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.clear)
            .frostedGlass(overlayOpacity: 0.7)
    }
}

#Preview {
    GamificationMissionTypeCardListView()
}

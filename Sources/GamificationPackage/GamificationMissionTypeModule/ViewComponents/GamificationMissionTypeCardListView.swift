//
//  GamificationMissionTypeCardListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionTypeCardListView: View {
    
    let missions: [GamificationMissionTypeDataModel.MissionTypeProgressEnum]
    
    let onPlayCLick: ((_ mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) -> ())
    
    var body: some View {
        VStack {
            missionTypeCardListView
        }
        .frame(width: 450)
        .padding()
        .background {
            backgroundFrostView
        }
        .gradientBorder()
    }
    
    
    private var missionTypeCardListView: some View {
        
        VStack(spacing: 18) {
            ForEach(Array(missions.enumerated()), id: \.element.id) { index, mission in
                
                GamificationMissionTypeCardItemView(
                    missionTypeModel: mission,
                    onPlayCLick: onPlayCLick
                )
                
                if index < missions.count - 1 {
                    Divider()
                        .background(.white)
                }
                
            }
        }
    }
    
    private var backgroundFrostView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.clear)
            .frostedGlass(overlayOpacity: 0.7)
    }
}

#Preview {
    let sampleMissionModel = GamificationDashboardDataModel.GamificationMissionResponseModel(
        totalMiniMission: 3,
        totalBossMission: 2,
        totalNormalMission: 5,
        completedMiniMission: 1,
        completedBossMission: 0,
        completedNormalMission: 2
    )
    
    GamificationMissionTypeCardListView(
        missions: [
            .miniMission(
                model: sampleMissionModel,
                courses: GamificationMissionTypeDataModel.PreviewData.sampleCourses
            ),
            .mission(
                model: sampleMissionModel,
                courses: GamificationMissionTypeDataModel.PreviewData.sampleCourses
            ),
            .bossMission(
                model: sampleMissionModel,
                courses: GamificationMissionTypeDataModel.PreviewData.sampleCourses
            )
        ],
        onPlayCLick: { _ in }
    )
}

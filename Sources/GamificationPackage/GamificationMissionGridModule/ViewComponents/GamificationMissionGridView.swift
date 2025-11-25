//
//  GamificationMissionGridView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 14/11/25.
//

import SwiftUI

struct GamificationMissionGridView: View {
    
    let courses: [GamificationMissionTypeDataModel.Course]
    
    let onLaunchMission: (_ mission: GamificationMissionTypeDataModel.Course) -> ()
    
    
    var body: some View {
        
        DynamicGridByScreenWidthWrapper(
            items: courses,
            minimumWidth: 300,
            
        ) { item in
            GamificationMissionGridItemView(
                course: item,
                onLaunchMission: onLaunchMission
            )
        }
    }
    
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationMissionGridView(
            courses: GamificationMissionTypeDataModel.PreviewData.sampleCourses,
            onLaunchMission: { _ in }
        )
    }
}



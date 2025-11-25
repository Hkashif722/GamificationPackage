//
//  GamificationAccomplishmentListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationAccomplishmentListView: View {
    
    let missionItems: [GamificationAccomplishementDataModel.MissionItem]
    
    var body: some View {
        VStack {
            gamificationAccomplishmentListView
        }
    }
    
    private var gamificationAccomplishmentListView: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(missionItems) { item in
                    GamificationAccomplishmentListItemView(
                        title: item.title,
                        completed: item.completed,
                        total: item.total
                    )
                    if item.id != missionItems.last?.id {
                        Divider()
                            .background(.white)
                    }
                }
            }
        }
        .versionedHorizontalBottomContentMargins()
        .applyScrollBounceBehavior()
    }
}

#Preview {
    GamificationAccomplishmentListView(
        missionItems: GamificationDashboardDataModel.GamificationMissionResponseModel.default.toMissionItems()
    )
}

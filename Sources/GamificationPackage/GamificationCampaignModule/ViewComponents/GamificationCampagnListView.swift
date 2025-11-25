//
//  GamificationCampagnListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationCampagnListView: View {
    
    let courses: [GamificationDashboardDataModel.GroupedCampaign.Course]
    let onCourseClick: (GamificationDashboardDataModel.GroupedCampaign.Course) -> Void
    
    var body: some View {
        gamificationPackageListView
    }
    
    
    private var gamificationPackageListView: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(Array(courses.enumerated()), id: \.element.id) { index, course in
                    GamificationCampaignListItemView(
                        course: course,
                        onClick: { onCourseClick(course) }
                    )
                    dividerView(index)
                }
            }
        }
        .versionedContentMargins()
        .applyScrollBounceBehavior()
    }
    
    @ViewBuilder
    private func dividerView(_ index: Int) -> some View {
        if index < courses.count - 1 {
            Divider()
                .background(.white)
        }
    }
}

#Preview {
    Color.gray.ignoresSafeArea()
    GamificationCampagnListView(
        courses: GamificationDashboardDataModel.GroupedCampaign.previewSingle.courses,
        onCourseClick: { _ in }
    )
}

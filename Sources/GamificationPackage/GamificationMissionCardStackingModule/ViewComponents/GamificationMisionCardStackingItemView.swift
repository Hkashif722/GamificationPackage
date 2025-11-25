//
//  GamificationMisionCardStackingItemView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationMisionCardStackingItemView: View {
    
    let missionType: String
    let course: GamificationMissionTypeDataModel.Course
    
    let onClick: () -> ()
    
    var body: some View {
        ZStack {
            gamificationMisionCardStackingItemView
        }
    }
    
    
    private var gamificationMisionCardStackingItemView: some View {
        VStack {
            missionTitleView
            SwiftUIUtility.GradientDivider()
            courseTitleView
            courseTypeSegmentView
            rewardPointsInfoView
            launchButtonView
        }
        .frame(width: 300, height: 220)
        .padding()
        .background { backgroundFrostView }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 0.5)
        }
        
    }
    
    
    private var missionTitleView: some View {
        Text(missionType)
            .appFont(.poppinsBold, size: 18, weight: .bold)
            .foregroundStyle(.white)
    }
    
    private var courseTitleView: some View {
        Text(course.title ?? "")
            .appFont(.poppinsSemiBold, size: 16, weight: .semibold)
            .foregroundStyle(.white)
    }
    
    private var courseCategoryView: some View {
        Text(course.categoryName ?? "")
            .appFont(.poppinsRegular, size: 14)
    }
    
    private var courseTypeSegmentView: some View {
        SwiftUIUtility.IconWithText(
            imageName: "ic_gm_course_type_classroom",
            text: course.courseType ?? "Classroom",
            isSystemImage: false,
            textColor: .white
        )
        .frame(width: 120)
        .padding(.init(top: 2, leading: 8, bottom: 2, trailing: 8))
        .reusableGradientBackground(
            stops: [
                .init(color: Color(hex:"#FCC306"), location: 0.1),
                .init(color: Color(hex: "#E99434"), location: 1.0)
            ],
            startPoint: .bottom,
            endPoint: .top
        )
        .clipShape(Capsule())
    }
    
    private var rewardPointsInfoView: some View {
        Text("You will get \(course.rewardPoint ?? 0) reward points")
            .appFont(.poppinsMedium, size: 16, weight: .medium)
            .foregroundStyle(.white)
    }
    
    private var launchButtonView: some View {
        SwiftUIUtility.RectangularGradientButton(
            title: "LAUNCH",
            gradient: LinearGradient(
                colors: [
                    Color(hex: "#192F3A"),
                    Color(hex: "#06C2C4")
                ],
                startPoint: .top,
                endPoint: .bottom
            ),
            foregroundColor: .white,
            borderColor: Color(hex: "#06C2C4"),
            height: 35,
            action: onClick
        )
        .frame(width: 125)
    }
    
    private var backgroundFrostView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.clear)
            .frostedGlass(overlayOpacity: 0.7)
    }
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationMisionCardStackingItemView(
            missionType: "Mini Mission",
            course: GamificationMissionTypeDataModel.PreviewData.sampleCourse,
            onClick: {}
        )
    }
}

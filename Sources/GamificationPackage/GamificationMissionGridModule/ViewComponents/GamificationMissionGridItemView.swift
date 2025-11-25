//
//  GamificationMissionGridItemView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionGridItemView: View {
    
    let course: GamificationMissionTypeDataModel.Course
    let onLaunchMission: (_ mission: GamificationMissionTypeDataModel.Course) -> ()
    
    var body: some View {
        
        HStack {
            missionInfoView
            launchButtonView
        }
        .padding()
        .background { backgroundFrostView }
        .gradientBorder()
        .minimumScaleFactor(0.2)
    }
    
    
    private var missionInfoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            missionTitleView
            missionMetaDataInfoView
            rewardPointsInfoView
        }
    }
    
    private var missionTitleView: some View {
        Text(course.title)
            .appFont(.poppinsSemiBold, size: 14, weight: .semibold)
            .foregroundStyle(.white)
    }
    
    private var missionMetaDataInfoView: some View {
        HStack {
            courseTitleView
            courseTypeSegmentView
        }
    }
    
    
    private var courseTitleView: some View {
        Text(course.categoryName ?? "Uncategorized")
            .appFont(.poppinsRegular, size: 14)
            .multilineTextAlignment(.leading)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var courseTypeSegmentView: some View {
        SwiftUIUtility.IconWithText(
            imageName: course.parsedCourseType.iconName,
            imageSize: .init(width: 20, height: 20),
            text: course.parsedCourseType.displayName,
            isSystemImage: false,
            font: .callout,
            textColor: .white
        )
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
            .appFont(.poppinsMedium, size: 12, weight: .medium)
            .foregroundStyle(ColorUtility.deepYellow)
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
            height: 25,
            font: .callout,
            action: { onLaunchMission(course) }
        )
        .frame(width: 65)
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
        GamificationMissionGridItemView(
            course: GamificationMissionTypeDataModel.PreviewData.sampleCourse,
            onLaunchMission: { _ in }
        )
    }
}


struct TopOnlyRoundedBorder: Shape {
    var radius: CGFloat = 20

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: radius))

        // top-leading curve
        path.addQuadCurve(
            to: CGPoint(x: radius, y: 0),
            control: CGPoint(x: 0, y: 0)
        )

        // top straight line
        path.addLine(to: CGPoint(x: rect.width - radius, y: 0))

        // top-trailing curve
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: radius),
            control: CGPoint(x: rect.width, y: 0)
        )

        return path
    }
}


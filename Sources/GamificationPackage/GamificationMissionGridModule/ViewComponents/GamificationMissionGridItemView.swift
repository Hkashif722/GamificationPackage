//
//  GamificationMissionGridItemView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMissionGridItemView: View {
    
    let onClick: () -> ()
    
    var body: some View {
        
        HStack {
            missionInfoView
            launchButtonView
        }
        .padding()
        .background { backgroundFrostView }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 2)
        }
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
        Text("Podh12345")
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
        Text("Mission Category Name")
            .appFont(.poppinsRegular, size: 14)
            .foregroundStyle(.white)
    }
    
    
    private var courseTypeSegmentView: some View {
        SwiftUIUtility.IconWithText(
            imageName: "ic_gm_course_type_classroom",
            text: "Classroom",
            isSystemImage: false,
            textColor: .white
        )
//        .frame(width: 120)
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
        Text("You will get 10 reward points")
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
            height: 30,
            font: .callout,
            action: onClick
        )
        .frame(width: 70)
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
        GamificationMissionGridItemView(onClick: {})
    }
}

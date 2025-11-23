//
//  GamificationMisionCardStackingListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMisionCardStackingListView: View {
    
    let mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum
    
    let onClickLaunch:( (_ mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) -> ())

    @State private var index = 1
    
    init(
        mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum,
        onClickLaunch: @escaping (_ mission: GamificationMissionTypeDataModel.MissionTypeProgressEnum) -> ()
    ) {
        self.mission = mission
        self.onClickLaunch = onClickLaunch
        _index = State(initialValue: mission.courses.count > 1 ? 1 : 0)
    }
    
    var body: some View {
        cardStackingListView
    }
    
    @ViewBuilder
    private var cardStackingListView: some View {
        if mission.courses.count > 0 {
            VStack {
                CarouselStackingView(
                    items: mission.courses, index: $index,
                    previousButton: { controlBackButtonView(
                        iconName: "chevron.left",
                        onClick: onPrevious
                    )},
                    nextButton: { controlBackButtonView(
                        iconName: "chevron.right",
                        onClick: onNext
                    )}
                ) { course in
                    GamificationMisionCardStackingItemView(
                        missionType: mission.rawValue,
                        course: course,
                        onClick: { onClickLaunch(mission) }
                    )
                }
            }
        }
    }
    
    
    private func onPrevious() {
        guard index > 0 else { return }
        index -= 1
    }
    
    private func onNext() {
        guard index < mission.courses.count - 1 else { return }
        index += 1
    }
    
    
}


//MARK: Utility
extension GamificationMisionCardStackingListView {
    
    private func controlBackButtonView(iconName: String, onClick: @escaping () -> ()) -> some View {
        
        SwiftUIUtility.RectangularGradientButton(
            iconName: iconName,
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
            height: 45,
            action: onClick
        )
        .frame(width: 45)
    }
    
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationMisionCardStackingListView(
            mission: .miniMission(
                model: .init(
                    totalMiniMission: 3,
                    totalBossMission: 2,
                    totalNormalMission: 5,
                    completedMiniMission: 1,
                    completedBossMission: 0,
                    completedNormalMission: 2
                ),
                courses: GamificationMissionTypeDataModel.PreviewData.sampleCourses
            ),
            onClickLaunch: { mission in
                print("Launched mission: \(mission.rawValue)")
            }
        )
    }
}

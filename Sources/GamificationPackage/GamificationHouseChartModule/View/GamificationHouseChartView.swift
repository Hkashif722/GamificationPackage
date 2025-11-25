//
//  GamificationHouseChartView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationHouseChartView: View {
    
    @StateObject private var hourseChartViewModel: GamificationHouseChartViewModel
    
    init(
        router: Router,
        houseChartModel: [GamificationHouseChartDataModel.HouseScoreModel]
    ) {
        _hourseChartViewModel = StateObject(
            wrappedValue: GamificationHouseChartViewModel(
                router: router,
                houseChartModel: houseChartModel
            )
        )
    }
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            closeButtonView
            
            ZStack{
                gamificationHouseChartView
            }
            .center()
            .ignoresSafeArea()
        }
        
    }
    
    
    private var gamificationHouseChartView: some View {
        VStack {
            GamificationHouseChartHeaderView(
                userHouseModel: GamificationHouseChartDataModel.HouseScoreModel.userHouse
            )
            houseChartView
        }
        .frame(maxWidth: 480)
        .background { backgroundFrostView }
        .padding(.vertical, 30)
    }
    
    private var houseChartView: some View {
        CustomBarChartView(
            data: hourseChartViewModel.houseChartModel,
            configuration: GamificationHouseChartDataModel.HouseScoreModel.chartConfiguration
        )
    }
    
    private var closeButtonView: some View {
        Button(action: hourseChartViewModel.dismissPopup) {
            Image("ic_gm_close", bundle: .module)
                .frame(width: 45, height: 45)
        }
        .padding()
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
        GamificationHouseChartView(
            router: Router(),
            houseChartModel: GamificationHouseChartDataModel.HouseScoreModel.houses
        )
    }
}

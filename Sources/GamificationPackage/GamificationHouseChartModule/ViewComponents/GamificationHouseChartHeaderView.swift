//
//  GamificationHouseChartHeaderView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationHouseChartHeaderView: View {
    
    @ObservedObject private var clubTypeData:GamificationClubTypeDataModel = .shared
    
    let userHouseModel: GamificationHouseChartDataModel.HouseScoreModel?
    
    var body: some View {
        HStack {
            currentHouseFalgView
            userNameTextView
            userProfileView
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
    }
    
    private var currentHouseFalgView: some View {
        CustomShapes.HalfRoundedRectangle()
            .fill(userHouseModel?.color ?? .red)
            .frame(width: 75, height: 20)
            .shadow(radius: 2)
    }
    
    private var userNameTextView: some View {
        Text(clubTypeData.userProfileDetail?.userName ?? "")
            .appFont(.poppinsRegular, size: 14, weight: .regular)
            .foregroundStyle(.white)
    }
    
    
    private var userProfileView: some View {
        SwiftUIUtility.ProfileImageViewWithVariableCorner(
            imageUrl: clubTypeData.userProfileDetail?.computedUseProlePictureURL,
            size: 40,
            profileBorderColor: .white
        )
    }
    
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        GamificationHouseChartHeaderView(userHouseModel: GamificationHouseChartDataModel.HouseScoreModel.houses[0])
    }
}


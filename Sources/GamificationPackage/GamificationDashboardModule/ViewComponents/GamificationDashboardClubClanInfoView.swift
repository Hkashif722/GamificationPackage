//
//  GamificationDashboardClubClanInfoView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//



///---------------------------------` Club Info Clan`-------------------------------------------------
///-------------------------------------------------
///-------------------------------------------------

import SwiftUI

internal struct GamificationDashboardClubClanInfoView: View {
    
    var body: some View {
        Group {
            clubInfoBannerImageView
            clanClubInfoView
        }
        
    }
    
    private var clubInfoBannerImageView: some View {
        Image(
            GamificationClubTypeDataModel.shared.clubType.clubLevelSticker,
            bundle: .module
        )
        .resizable()
        .frame(width: 150, height: 180)
        .topLeading()
    }
    
    
    private var clanClubInfoView: some View {
        Group {
            clanClubNameBackhroundView
                .overlay {
                    clubNameView
                }
        }
        .padding(.top, 16)
        .top()
    }
    private var clanClubNameBackhroundView: some View {
        Image(.clanClubBg)
            .resizable()
            .frame(width: 250, height: 45)
    }
    
    private var clubNameView: some View {
        Text(GamificationClubTypeDataModel.shared.clubType.rawValue)
            .appFont(.quanticoBold, size: 22)
            .foregroundStyle(.white)
    }
    
    
}

#Preview {
    GamificationDashboardClubClanInfoView()
}

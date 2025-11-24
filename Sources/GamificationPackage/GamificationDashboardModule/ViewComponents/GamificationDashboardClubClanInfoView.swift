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
    
    @ObservedObject private var clubTypeModel = GamificationClubTypeDataModel.shared
    
    let router: Router
    
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
        .scaledToFit()
        .frame(width: 150, height: 180)
        .topLeading()
        .offset(y: -13)
        .onTapGesture {
            router.presentPopup(.clubLeveType)
        }
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
        Text(clubTypeModel.clubType.rawValue)
            .appFont(.quanticoBold, size: 22)
            .foregroundStyle(.white)
    }
    
    
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationDashboardClubClanInfoView(router: Router())
    }
    .fullSize()
    .ignoresSafeArea()
}

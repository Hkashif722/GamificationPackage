//
//  GamificationClubLevelView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct GamificationClubLevelView: View {
    
    @StateObject var gamificationClubLevelViewModel: GamificationClubLevelViewModel
   
    
    init(router: Router) {
        _gamificationClubLevelViewModel = StateObject(
            wrappedValue: GamificationClubLevelViewModel(router: router)
        )
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            closeButtonView
            ZStack {
                
                clubLevelItemListView
                
            }
            .center()
            .ignoresSafeArea()
            .onAppear {
                gamificationClubLevelViewModel.isAnimating = true
            }
        }
    }
    
    private var clubLevelItemListView: some View {
        HStack(spacing: 16) {
            ForEach(
                Array(GamificationClubTypeDataModel.ClubType.allCases.enumerated()),
                id: \.element
            ) { index, club in
                clubItemView(for: club, at: index)
            }
        }
    }

    private func clubItemView(for club: GamificationClubTypeDataModel.ClubType, at index: Int) -> some View {
        GamificationClubLevelItemView(
            gamificationClubTypeModel: gamificationClubLevelViewModel.gamificationClubTypeModel,
            clubType: club,
            isClubLocked: club == gamificationClubLevelViewModel.selectedClub,
            onViewClub: gamificationClubLevelViewModel.handleViewCLub(_:)
        )
        .shadow(
            color: gamificationClubLevelViewModel.selectedClub == club
            ? gamificationClubLevelViewModel.shadowColor
            : .clear,
            radius: 8
        )
        .scaleEffect(gamificationClubLevelViewModel.isAnimating ? 1.0 : 0.8)
        .animation(
            .spring(response: 0.6, dampingFraction: 0.7)
            .delay(Double(index) * 0.15),
            value: gamificationClubLevelViewModel.isAnimating
        )
    }
    
    private var closeButtonView: some View {
        Button(action: gamificationClubLevelViewModel.dismissPopup) {
            Image("ic_gm_close", bundle: .module)
                .frame(width: 45, height: 45)
        }
        .padding()
    }

    
}


#Preview {
    GamificationClubLevelView(router: Router())
}

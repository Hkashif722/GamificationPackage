//
//  GamificationClubLevelItemView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationClubLevelItemView: View {
    
    let clubItemSolidBackgroundColor: Color = Color(hex: "#2D0041")
    
    let clubType: GamificationClubTypeDataModel.ClubType
    
    let isClubLocked: Bool

    
    var body: some View {
        clubLevelItemView
    }
    
    private var clubLevelItemView: some View {
        ZStack {
            clubLevelbackGroundSolidColorView
            clubLevelItemInfoView
            lockedOverlayView
        }
        .frame(width: 120, height: 270)
        .cornerRadius(20, corners: .allCorners)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 2)
        }
    }
    
    private var clubLevelbackGroundSolidColorView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(clubItemSolidBackgroundColor)
    }
    
    
    private var clubLevelItemInfoView: some View {
        VStack(spacing: 20) {
            clubStickerVew
            scoreView
            viewClubButtonView
        }
        .padding(.bottom)
    }
    
    private var clubStickerVew: some View {
        clubBGGradentBGView
            .overlay {
                clanStickerView
            }
            .topLeading()
    }
    private var clubBGGradentBGView: some View {
        Image(clubType.clubLevelBackground, bundle: .module)
            .resizable()
            .scaledToFill()
            .frame(width: 120, height: 140)
            .cornerRadius(20, corners: [.topLeft, .topRight])
    }
    
    
    private var clanStickerView: some View {
        Image(clubType.clubLevelSticker, bundle: .module)
            .resizable()
            .scaledToFit()
            .frame(width: 85, height: 85)
            .offset(y: -10)
        
    }
    
    
    private var scoreView: some View {
        VStack(spacing: 4) {
            scoreLabelView
            scoreDataView
        }
        .appFont(.robotoBlack, size: 16, weight: .heavy)
    }
    
    
    private var scoreLabelView: some View {
        Text("SCORE")
            .foregroundStyle(.white)
    }
    
    private var scoreDataView: some View {
        Text("5-50")
            .foregroundStyle(.white)
    }
    
    private var viewClubButtonView: some View {
        
        Button(action: {}) {
            
            Image("gm_view_club_btn_bg", bundle: .module)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .overlay {
                    Text("View Club")
                        .appFont(.poppinsSemiBold, size: 12, weight: .bold)
                        .foregroundStyle(.white)
                }
        }
    }
    
    @ViewBuilder
    private var lockedOverlayView: some View {
        if isClubLocked {
            ZStack {
                Color.black.opacity(0.4)
                
                Image("gm_ic_lock", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 40)
            }
        }
    }
}

#Preview {
    GamificationClubLevelItemView(clubType: .master, isClubLocked: true)
}

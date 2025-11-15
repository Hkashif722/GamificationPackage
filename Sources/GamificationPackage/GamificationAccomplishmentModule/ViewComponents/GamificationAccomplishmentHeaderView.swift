//
//  GamificationAccomplishmentHeaderView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 11/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationAccomplishmentHeaderView: View {
    
    var body: some View {
       
        ZStack(alignment: .bottom) {
            dividerView
            gamificationAccomplishmentHeaderView
        }
        
    }
    
    

    private var gamificationAccomplishmentHeaderView: some View {
        HStack {
            stickerUserInfoView
            profileInfoView
        }
    }
    
    private var stickerUserInfoView: some View {
        HStack {
            clubStikerView
            userInfoView
        }
    }
    
    
    private var profileInfoView: some View {
        HStack {
            profilePictureView
            profilePointView
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    
    //MARK: Club Sticker View
    private var clubStikerView: some View {
        Image(
            GamificationClubTypeDataModel.ClubType.knight.getGamificationClublevelSticker
        )
        .resizable()
        .scaledToFit()
        .frame(width: 80, height: 120)
    }
    
    //------------
    //MARK: User Info
    private var userInfoView: some View {
        VStack {
            userNameTextView
            pointsView
        }
        .foregroundStyle(.white)
    }
    
    private var userNameTextView: some View {
        Text("Lmsadmin")
            .appFont(.poppinsSemiBold, size: 14, weight: .semibold)
    }
    
    private var pointsView: some View {
        Text("7999")
            .appFont(.poppinsSemiBold, size: 14, weight: .semibold)
            .foregroundStyle(BrandingColorStyle.deepBlue)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .reusableGradientBackground(
                stops: [
                    .init(color: Color(hex:"#FFFEC5"), location: 0.0),
                    .init(color: Color(hex:"#BECA39"), location: 1.0),
                ]
            )
            .background (
                Capsule().stroke()
            )
            .clipShape(Capsule())
    }
    
    
    //------------
    //MARK: Profile Picture and Points
    private var profilePictureView: some View {
        SwiftUIUtility.ProfileImageViewWithVariableCorner(
            imageUrl: URL(string: ""),
            size: 50,
            cornerRadius: 10,
            profileBorderColor: .white
        )
    }
    
    private var profilePointView: some View {
        Text("7999")
            .appFont(.poppinsBold, size: 16, weight: .bold)
            .softCapsuleBorder()
    }
    
    private var dividerView: some View {
        SwiftUIUtility.GradientDivider(
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(maxWidth: .infinity)
        .offset(y: -10)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        GamificationAccomplishmentHeaderView()
    }
}

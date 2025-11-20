//
//  GamificationDashboardProfileItemsView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//



import SwiftUI

internal struct GamificationDashboardProfileItemsView: View {
    
    let userProfileDetail = GamificationClubTypeDataModel.shared.userProfileDetail
    
    var body: some View {
        
        ZStack {
            HStack(alignment: .top, spacing: 0) {
                
                profileImageView
                
                profileInfoView
                
            }
        }
        .bottomLeading()
        .offset(y: -10)
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var profileImageView: some View {
        SwiftUIUtility.ProfileImageView(
            imageUrl: userProfileDetail?.computedUseProlePictureURL,
            size: 82,
            profileBorderColor: .white,
            borderWidth: 5
        )
        .zIndex(2)
    }
    
    
    private var profileInfoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            welcomeTextMessageView
            profileNameView
            houseNameTextView
        }
        .offset(x: -50, y: -3)
        .zIndex(1)
    }
    
    private var welcomeTextMessageView: some View {
        Text("WELCOME")
            .appFont(.poppinsRegular, size: 12)
            .foregroundStyle(ColorUtility.label)
            .padding(.init(top: 5, leading: 45, bottom: 5, trailing: 15))
            .background(.white)
            .clipShape(Capsule())
           
            
    }
    
    @ViewBuilder
    private var profileNameView: some View {
        if let userName = userProfileDetail?.userName {
            Text(userName)
                .appFont(.poppinsBold, size: 12, weight: .bold)
                .foregroundStyle(.white)
                .padding(.init(top: 8, leading: 55, bottom: 8, trailing: 25))
                .background(ColorUtility.primaryColor)
                .clipShape(Capsule())
        }
    }
    
    @ViewBuilder
    private var houseNameTextView: some View {
        if let house = userProfileDetail?.house {
            Text(house)
                .appFont(.poppinsRegular, size: 12)
                .foregroundStyle(ColorUtility.label)
                .padding(.init(top: 5, leading: 45, bottom: 5, trailing: 15))
                .background(.white)
                .clipShape(Capsule())
        }
    }
    
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 3)
        GamificationDashboardProfileItemsView()
    }
}

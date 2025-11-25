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
    
    let router: Router
    
    var body: some View {
        
        ZStack {
            HStack(alignment: .top, spacing: 0) {
                
                profileImageView
                
                profileInfoView
                
            }
        }
        .bottomLeading()
        .offset(x: 15,y: -10)
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var profileImageView: some View {
        SwiftUIUtility.ProfileImageView(
            imageUrl: userProfileDetail?.computedUseProlePictureURL,
            size: 81,
            profileBorderColor: .white,
            borderWidth: 5
        )
        .onTapGesture {
            router.presentPopup(.accomplishment)
        }
        .zIndex(2)
        .overlay(alignment: .leading) {
            gmaificationHouIconView
                .offset(x: -10,y:-15)
        }
    }
    
    
    private var profileInfoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            welcomeTextMessageView
            profileNameView
            houseNameTextView
        }
        .offset(x: -53, y: -3)
        .zIndex(1)
    }
    
    private var welcomeTextMessageView: some View {
        Text("WELCOME")
            .appFont(.poppinsRegular, size: 12.4)
            .foregroundStyle(ColorUtility.label)
            .padding(.init(top: 5, leading: 48, bottom: 5, trailing: 15))
            .background(.white)
            .clipShape(Capsule())
           
            
    }
    
    @ViewBuilder
    private var profileNameView: some View {
        if let userName = userProfileDetail?.userName {
            Text(userName)
            .appFont(.poppinsBold, size: 12.4, weight: .bold)
                .foregroundStyle(.white)
                .padding(.init(top: 8, leading: 60, bottom: 8, trailing: 25))
                .background(ColorUtility.primaryColor)
                .clipShape(Capsule())
        }
    }
    
    @ViewBuilder
    private var houseNameTextView: some View {
        if let house = userProfileDetail?.house {
            Text(house)
            .appFont(.poppinsRegular, size: 12.4)
                .foregroundStyle(ColorUtility.label)
                .padding(.init(top: 5, leading: 48, bottom: 5, trailing: 15))
                .background(.white)
                .clipShape(Capsule())
        }
    }
    
    private var gmaificationHouIconView: some View {
        Image(.gmIcHouse)
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
            .onTapGesture {
                router.presentPopup(.houseChart)
            }
    }
    
}


struct GamificationDashboardProfileItemsView_Preview: View {
    
    init() {
        FontRegistrar.registerAllFonts()
    }
    
    var body: some View {
        ZStack {
            GamificationDashboardBackgroundView()
                .blur(radius: 3)
            GamificationDashboardProfileItemsView(router:Router())
        }
        .fullSize()
        .ignoresSafeArea()
    }
}

#Preview {
    GamificationDashboardProfileItemsView_Preview()
}

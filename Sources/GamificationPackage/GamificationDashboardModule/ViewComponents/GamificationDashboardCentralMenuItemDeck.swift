//
//  GamificationCentralMenuItemDeck.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 03/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//



///---------------------------------` Gamification Centeral Menu Item Deck Control `-------------------------------------------------
///-------------------------------------------------
///-------------------------------------------------


import SwiftUI

internal struct GamificationDashboardCentralMenuItemDeck: View {
    
    let onAction: ((_ type: GamificationDashboardDataModel.MenuTrayActionButtons.ActionType) -> ())
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            centerDeckMenuTrayBackground
            archTrayMenuButtonsView
        }
        .bottom()
        .ignoresSafeArea()
        
        
    }
    
    
    
    private var centerDeckMenuTrayBackground: some View {
        Image("gm_center_deck_menu_bg", bundle: .module)
            .resizable()
            .scaledToFill()
            .frame(width: 260, height: 260)
            .clipShape(Circle())
            .offset(y: 115)
           
    }

    private var archTrayMenuButtonsView: some View {
        
        CustomViewLayout.ArcLayoutContainer(
            radius: 100,
            startAngle: .degrees(180),
            arcAngle: .degrees(180),
            tiltFactor: 0.9,
            isAnimate: true
        ) {
            ForEach(GamificationDashboardDataModel.MenuTrayActionButtons.getActionMenuModel) { action in
                
                SwiftUIUtility.RoundMenuButton(
                    image: .asset(name: action.actionType.getImageAssestName),
                    buttonSize: 68,
                    backgroundColor: .clear,
                    action: { onAction(action.actionType) }
                )
            }
        }
        .offset(y: -25)
        
    }
}


#Preview {
    GamificationDashboardCentralMenuItemDeck(onAction: { _ in })
}

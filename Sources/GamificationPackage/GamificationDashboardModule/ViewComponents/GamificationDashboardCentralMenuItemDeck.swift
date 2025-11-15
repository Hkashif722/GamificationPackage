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

struct GamificationDashboardCentralMenuItemDeck: View {
    
    struct MenuTrayActionButtons: Identifiable {
        
        enum ActionType {
            case happyLearningHour
            case criticalMission
            case leaderboard
            case mission
            case dailyLoginBonus
            case campaigns
            case campaignLeaderboard
            
            var getImageAssestName: String {
                switch self {
                  
                case .happyLearningHour:
                    return "ic_gm_happy_Hour"
                case .criticalMission:
                    return "ic_gm_critical_mission"
                case .leaderboard:
                    return "ic_gm_leaderboard"
                case .mission:
                    return "ic_gm_mission"
                case .dailyLoginBonus:
                    return "ic_gm_daily_bonus"
                case .campaigns:
                    return "ic_gm_campign"
                case .campaignLeaderboard:
                    return "ic_gm_camping_leaderboard"
                }
            }
        }
        
        let id: UUID = UUID()
        let actionType: ActionType
        
        init(actionType: ActionType) {
            self.actionType = actionType
        }
        
        static var getActionMenuModel: [Self] {
            [
                .init(actionType: .happyLearningHour),
                .init(actionType: .criticalMission),
                .init(actionType: .leaderboard),
                .init(actionType: .mission),
                .init(actionType: .dailyLoginBonus),
                .init(actionType: .campaigns),
                .init(actionType: .campaignLeaderboard)
            ]
        }
    }
    
    let onAction: ((_ type: MenuTrayActionButtons.ActionType) -> ())
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            centerDeckMenuTrayBackground
            archTrayMenuButtonsView
        }
        .bottom()
        .ignoresSafeArea()
        
        
    }
    
    
    
    private var centerDeckMenuTrayBackground: some View {
        Image("gm_center_deck_menu_bg")
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
            ForEach(MenuTrayActionButtons.getActionMenuModel) { action in
                
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

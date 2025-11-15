//
//  GamificationMissionGridView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 14/11/25.
//

import SwiftUI

struct GamificationMissionGridView: View {
    
    struct ExampleCard: Identifiable, Hashable {
        let id = UUID()
        let title: String
        let color: Color
    }
    
    let data = [
        ExampleCard(title: "Mini Missions", color: .purple),
        ExampleCard(title: "Gamification", color: .blue),
        ExampleCard(title: "Web Dev", color: .indigo),
        ExampleCard(title: "Backend API", color: .cyan)
    ]
    
    
    var body: some View {
        
        DynamicGridByScreenWidthWrapper(
            items: data,
            minimumWidth: 300,
            
        ) { item in
            GamificationMissionGridItemView(onClick: {})
        }
    }
    
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationMissionGridView()
    }
}


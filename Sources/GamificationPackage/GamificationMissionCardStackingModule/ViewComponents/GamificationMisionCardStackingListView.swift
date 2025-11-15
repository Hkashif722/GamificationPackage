//
//  GamificationMisionCardStackingListView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 13/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct GamificationMisionCardStackingListView: View {
    struct ExampleCard: Identifiable {
        let id = UUID()
        let title: String
        let color: Color
    }

    @State private var index = 1
    
    let data = [
        ExampleCard(title: "Mini Missions", color: .purple),
        ExampleCard(title: "Gamification", color: .blue),
        ExampleCard(title: "Web Dev", color: .indigo),
        ExampleCard(title: "Backend API", color: .cyan)
    ]
    
    var body: some View {
        cardStackingListView
    }
    
    private var cardStackingListView: some View {
        VStack {
            CarouselStackingView(
                items: data, index: $index,
                previousButton: { controlBackButtonView(
                    iconName: "chevron.left",
                    onClick: onPrevious
                )},
                nextButton: { controlBackButtonView(
                    iconName: "chevron.right",
                    onClick: onNext
                )}
            ) { item in
                GamificationMisionCardStackingItemView(onClick: {})
            }
        }
    }
    
    
    private func onPrevious() {
        guard index > 0 else { return }
        index -= 1
    }
    
    private func onNext() {
        guard index < data.count - 1 else { return }
        index += 1
    }
    
    
}


//MARK: Utility
extension GamificationMisionCardStackingListView {
    
    private func controlBackButtonView(iconName: String, onClick: @escaping () -> ()) -> some View {
        
        SwiftUIUtility.RectangularGradientButton(
            iconName: iconName,
            gradient: LinearGradient(
                colors: [
                    Color(hex: "#192F3A"),
                    Color(hex: "#06C2C4")
                ],
                startPoint: .top,
                endPoint: .bottom
            ),
            foregroundColor: .white,
            borderColor: Color(hex: "#06C2C4"),
            height: 45,
            action: onClick
        )
        .frame(width: 45)
    }
    
}

#Preview {
    ZStack {
        GamificationDashboardBackgroundView()
            .blur(radius: 4)
        GamificationMisionCardStackingListView()
    }
}

//
//  GamificationMisionCardStackingViewAllButtonView.swift.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 23/11/25.
//

import SwiftUI


struct GamificationMisionCardStackingViewAllButtonView: View {
    
    let onClickViewAll: (() -> ())
    
    var body: some View {
        ZStack {
            ViewAllButtonView
        }
        .fullSize(alignment: .bottomTrailing)
        .ignoresSafeArea(.all)
        
    }
    
    private var ViewAllButtonView: some View {
        SwiftUIUtility.RectangularGradientButton(
            title: "ViewAll",
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
            height: 35,
            action: onClickViewAll
        )
        .frame(width: 95)
        .padding(.init(top: 20, leading: 10, bottom: 10, trailing: 45))
    }
}


#Preview {
    GamificationMisionCardStackingViewAllButtonView(onClickViewAll: {})
}

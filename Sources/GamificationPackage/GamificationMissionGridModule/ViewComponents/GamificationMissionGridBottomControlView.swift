//
//  GamificationBottomControlView.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 14/11/25.
//

import SwiftUI

struct GamificationMissionGridBottomControlView: View {
    
    var body: some View {
        
        VStack {
            campaignHeaderControlView
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .minimumScaleFactor(0.5)
        
    }
    
    
    private var campaignHeaderControlView: some View {
        HStack(spacing: 16) {
            controlBackButtonView(iconName: "chevron.left", onClick: {})
            paginationInfoView
            controlBackButtonView(iconName: "chevron.right", onClick: {})
        }
    }
    
    
    private var paginationInfoView: some View {
        Text("1-4 / 10")
            .appFont(.poppinsSemiBold, size: 18, weight: .semibold)
            .foregroundStyle(Color(hex: "#00F1D8"))
    }

}


//MARK: Utility
extension GamificationMissionGridBottomControlView {
    
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
            height: 30,
            action: onClick
        )
        .frame(width: 30)
    }
    
}

#Preview {
    GamificationMissionGridBottomControlView()
}

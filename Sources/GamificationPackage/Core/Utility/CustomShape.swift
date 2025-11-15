//
//  File.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 14/11/25.
//

import SwiftUI

internal struct CustomShapes {
    

    struct HalfRoundedRectangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            // Top-left corner with a radius
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 20))
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + 20, y: rect.minY),
                control: CGPoint(x: rect.minX, y: rect.minY)
            )
            
            // Top edge and top-right corner
            path.addLine(to: CGPoint(x: rect.maxX - 20, y: rect.minY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY + 20),
                control: CGPoint(x: rect.maxX, y: rect.minY)
            )
            
            // Right and bottom edges (flat)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            path.closeSubpath()
            return path
        }
    }
    
}

//
//  File.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 14/11/25.
//

import SwiftUI

internal struct CustomViewModifier {
    struct RoundedCorner: Shape {
        var radius: CGFloat = .infinity
        var corners: UIRectCorner = .allCorners
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
    
    
    // MARK: - Frosted Glass Modifier
    struct FrostedGlassModifier: ViewModifier {
        var corners: UIRectCorner
        var cornerRadius: CGFloat
        var blurStyle: UIBlurEffect.Style
        var overlayOpacity: Double
        var strokeColor: Color
        var strokeWidth: CGFloat
        
        init(
            corners: UIRectCorner = .allCorners,
            cornerRadius: CGFloat = 16,
            blurStyle: UIBlurEffect.Style = .systemUltraThinMaterialDark,
            overlayOpacity: Double = 0.15,
            strokeColor: Color = Color.white.opacity(0.2),
            strokeWidth: CGFloat = 1
        ) {
            self.corners = corners
            self.cornerRadius = cornerRadius
            self.blurStyle = blurStyle
            self.overlayOpacity = overlayOpacity
            self.strokeColor = strokeColor
            self.strokeWidth = strokeWidth
        }
        
        @available(iOS 16.0, *)
        private var cornerRadii: RectangleCornerRadii {
            RectangleCornerRadii(
                topLeading: corners.contains(.topLeft) ? cornerRadius : 0,
                bottomLeading: corners.contains(.bottomLeft) ? cornerRadius : 0,
                bottomTrailing: corners.contains(.bottomRight) ? cornerRadius : 0,
                topTrailing: corners.contains(.topRight) ? cornerRadius : 0
            )
        }
        
        func body(content: Content) -> some View {
            if #available(iOS 16.0, *) {
                content
                    .background(
                        ZStack {
                            // Adaptive blur that picks up background colors
                            //                        AdaptiveBlurView(style: blurStyle)
                            UIKitBridgeVCRepresentable.BlurView(style: blurStyle)
                            
                            // Optional gradient overlay for depth
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(overlayOpacity),
                                    Color.white.opacity(overlayOpacity * 0.5)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .blendMode(.overlay)
                        }
                            .clipShape(UnevenRoundedRectangle(cornerRadii: cornerRadii))
                    )
                    .overlay(
                        UnevenRoundedRectangle(cornerRadii: cornerRadii)
                            .stroke(strokeColor, lineWidth: strokeWidth)
                    )
            } else {
                // iOS 15 fallback
                content
                    .background(
                        ZStack {
                            // Adaptive blur that picks up background colors
                            UIKitBridgeVCRepresentable.BlurView(style: blurStyle)
                            
                            // Optional gradient overlay for depth
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(overlayOpacity),
                                    Color.white.opacity(overlayOpacity * 0.5)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .blendMode(.overlay)
                        }
                            .clipShape(RoundedCorner(radius: cornerRadius, corners: corners))
                    )
                    .overlay(
                        RoundedCorner(radius: cornerRadius, corners: corners)
                            .stroke(strokeColor, lineWidth: strokeWidth)
                    )
            }
        }
    }
    
    
    
    
    // MARK: Gradient Border Capsule
    struct SoftCapsuleBorderModifier: ViewModifier {
        var backgroundColor: Color = Color(red: 48/255, green: 51/255, blue: 87/255)
        var borderStartOpacity: Double = 0.25
        var borderEndOpacity: Double = 0.05
        var shadowOpacity: Double = 0.08
        var lineWidth: CGFloat = 1.2
        
        func body(content: Content) -> some View {
            content
                .padding(.horizontal, 30)
                .padding(.vertical, 14)
                .background(
                    Capsule()
                        .fill(backgroundColor)
                        .overlay(
                            Capsule()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(borderStartOpacity),
                                            Color.white.opacity(borderEndOpacity)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: lineWidth
                                )
                        )
                        .shadow(color: .white.opacity(shadowOpacity), radius: 2, x: 0, y: 1)
                )
        }
    }
    
    
    struct VersionedLineLimitModifier: ViewModifier {
        let lineLimit: Int
        let reservesSpace: Bool

        @ViewBuilder
        func body(content: Content) -> some View {
            if #available(iOS 16, *) {
                content.lineLimit(lineLimit, reservesSpace: reservesSpace)
            } else {
                content.lineLimit(lineLimit)
            }
        }
    }
    
    
    struct VersionedContentMargins: ViewModifier {
        func body(content: Content) -> some View {
            if #available(iOS 17.0, *) {
                // Use contentMargins on iOS 17 or later
                content
                    .contentMargins(.all, 10, for: .scrollContent)
                    .contentMargins(.top, -10, for: .scrollIndicators)
            } else {
                // Fallback to padding for earlier versions
                content
                    .padding(10)
            }
        }
    }
    
    
    ///
    /// ------------------------------------------------   ` <<<<<<<<< Background gradient Modifier  >>>>>>>>>>>>>>`   -----------------------------------------------------------------------------
    ///
    struct GradientBackgroundModifier: ViewModifier {
        let stops: [Gradient.Stop]
        let startPoint: UnitPoint
        let endPoint: UnitPoint

        init(
            stops: [Gradient.Stop] = [
                .init(color: Color.blue, location: 0.0),
                .init(color: Color.blue.opacity(0.7), location: 0.5),
                .init(color: Color.gray.opacity(0.3), location: 0.8),
                .init(color: Color.gray, location: 1.0)
            ],
            startPoint: UnitPoint = .top,
            endPoint: UnitPoint = .bottom
        ) {
            self.stops = stops
            self.startPoint = startPoint
            self.endPoint = endPoint
        }

        func body(content: Content) -> some View {
            content
                .background(
                    LinearGradient(
                        gradient: Gradient(stops: stops),
                        startPoint: startPoint,
                        endPoint: endPoint
                    )
                    .ignoresSafeArea() // Extend to fill the safe area
                )
        }
    }


}



internal extension View {
    // MARK: - Full Size with Alignment
    
    func fullSize(alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    // MARK: - Corner Positions
    
    func topLeading() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    func topTrailing() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
    
    func bottomLeading() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }
    
    func bottomTrailing() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    // MARK: - Edge Positions
    
    func top() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func bottom() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
    
    func leading() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
    func trailing() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
    
    // MARK: - Center Positions
    
    func center() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func centerHorizontally() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func centerVertically() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }
    
    
    
    //MARK: UI Border Related Extension
    
    /// Modifier for rounding specific corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CustomViewModifier.RoundedCorner(radius: radius, corners: corners))
    }
    
    
    
    //MARK: View Background Related Modifier
    
    
    func frostedGlass(
        corners: UIRectCorner = .allCorners,
        cornerRadius: CGFloat = 16,
        blurStyle: UIBlurEffect.Style = .systemUltraThinMaterialDark,
        overlayOpacity: Double = 0.15,
        strokeColor: Color = Color.white.opacity(0.2),
        strokeWidth: CGFloat = 1
    ) -> some View {
        modifier(CustomViewModifier.FrostedGlassModifier(
            corners: corners,
            cornerRadius: cornerRadius,
            blurStyle: blurStyle,
            overlayOpacity: overlayOpacity,
            strokeColor: strokeColor,
            strokeWidth: strokeWidth
        ))
    }
    
    func softCapsuleBorder(
        backgroundColor: Color = Color(red: 48/255, green: 51/255, blue: 87/255),
        borderStartOpacity: Double = 0.25,
        borderEndOpacity: Double = 0.05,
        shadowOpacity: Double = 0.08,
        lineWidth: CGFloat = 1.2
    ) -> some View {
        self.modifier(
            CustomViewModifier.SoftCapsuleBorderModifier(
                backgroundColor: backgroundColor,
                borderStartOpacity: borderStartOpacity,
                borderEndOpacity: borderEndOpacity,
                shadowOpacity: shadowOpacity,
                lineWidth: lineWidth
            )
        )
    }
    
    
    func versionedLineLimit(_ lineLimit: Int = 1, reservesSpace: Bool = true) -> some View {
        self.modifier(CustomViewModifier.VersionedLineLimitModifier(lineLimit: lineLimit, reservesSpace: reservesSpace))
    }
    
    func versionedContentMargins() -> some View {
        self.modifier(CustomViewModifier.VersionedContentMargins())
    }
    
    
    @ViewBuilder
    func applyScrollBounceBehavior() -> some View {
        if #available(iOS 16.4, *) {
            self.scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        } else {
            self // No-op for iOS 15 or earlier
        }
    }
    
    
    /// Attaches a reusable, customizable gradient background to any view.
    ///
    /// - Parameters:
    ///   - stops: An array of `Gradient.Stop` values defining the colors and locations.
    ///   - startPoint: The starting point of the gradient (default is `.top`).
    ///   - endPoint: The ending point of the gradient (default is `.bottom`).
    /// - Returns: A view with the gradient background applied.
    func reusableGradientBackground(
        stops: [Gradient.Stop]? = nil,
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom
    ) -> some View {
        // Use custom stops if provided; otherwise, use the default stops.
        let gradientStops = stops ?? [
            .init(color: Color.blue, location: 0.0),
            .init(color: Color.blue.opacity(0.7), location: 0.5),
            .init(color: Color.gray.opacity(0.3), location: 0.8),
            .init(color: Color.gray, location: 1.0)
        ]
        return self.modifier(CustomViewModifier.GradientBackgroundModifier(stops: gradientStops, startPoint: startPoint, endPoint: endPoint))
    }
    
    
}

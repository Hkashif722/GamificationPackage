//
//  CustomViewLayout.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 14/11/25.
//


//
//  CustomViewLayout.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 31/10/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

internal struct CustomViewLayout {

    // MARK: - Arc Layout (iOS 16+)
    @available(iOS 16.0, *)
    private struct ArcLayout: Layout {
        var radius: CGFloat
        var startAngle: Angle
        var arcAngle: Angle
        var tiltFactor: CGFloat
        
        init(radius: CGFloat = 120,
             startAngle: Angle = .degrees(180),
             arcAngle: Angle = .degrees(180),
             tiltFactor: CGFloat = 1.0) {
            self.radius = radius
            self.startAngle = startAngle
            self.arcAngle = arcAngle
            self.tiltFactor = tiltFactor
        }
        
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
            let width = radius * 2
            let maxHeight = radius * (1 - cos(arcAngle.radians / 2)) * 2 * tiltFactor
            return CGSize(width: width, height: maxHeight)
        }
        
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
            let center = CGPoint(x: bounds.midX, y: bounds.maxY)
            
            guard subviews.count > 0 else { return }
            
            let angleStep = subviews.count > 1 ? arcAngle.radians / Double(subviews.count - 1) : 0
            
            for (index, subview) in subviews.enumerated() {
                let angle = startAngle.radians + (angleStep * Double(index))
                
                let x = center.x + radius * cos(angle)
                let y = center.y + radius * sin(angle) * tiltFactor
                
                subview.place(at: CGPoint(x: x, y: y), anchor: .center, proposal: .unspecified)
            }
        }
    }

    // MARK: - Arc Layout Container (iOS 15+ Compatible)
    struct ArcLayoutContainer<Content: View>: View {
        let content: Content
        var radius: CGFloat
        var startAngle: Angle
        var arcAngle: Angle
        var tiltFactor: CGFloat
        var isAnimate: Bool
        var animateItemsSequentially: Bool
        var itemDelay: Double
        var springResponse: Double
        var springDamping: Double
        
        @State private var visibleItems: Set<Int> = []
        @State private var itemCount: Int = 0
        
        init(radius: CGFloat = 120,
             startAngle: Angle = .degrees(180),
             arcAngle: Angle = .degrees(180),
             tiltFactor: CGFloat = 1.0,
             isAnimate: Bool = false,
             animateItemsSequentially: Bool = false,
             itemDelay: Double = 0.1,
             springResponse: Double = 0.6,
             springDamping: Double = 0.7,
             @ViewBuilder content: () -> Content) {
            self.content = content()
            self.radius = radius
            self.startAngle = startAngle
            self.arcAngle = arcAngle
            self.tiltFactor = tiltFactor
            self.isAnimate = isAnimate
            self.animateItemsSequentially = animateItemsSequentially
            self.itemDelay = itemDelay
            self.springResponse = springResponse
            self.springDamping = springDamping
        }
        
        var body: some View {
            Group {
                if #available(iOS 16.0, *) {
                    ArcLayout(radius: radius, startAngle: startAngle, arcAngle: arcAngle, tiltFactor: tiltFactor) {
                        wrappedContent
                    }
                } else {
                    _VariadicView.Tree(ArcLayoutLegacy(
                        radius: radius,
                        startAngle: startAngle,
                        arcAngle: arcAngle,
                        tiltFactor: tiltFactor,
                        visibleItems: visibleItems
                    )) {
                        wrappedContent
                    }
                }
            }
            .animation(isAnimate ? .easeInOut : nil, value: radius)
            .animation(isAnimate ? .easeInOut : nil, value: tiltFactor)
            .onAppear {
                if animateItemsSequentially {
                    animateItemsOneByOne()
                }
            }
        }
        
        @ViewBuilder
        private var wrappedContent: some View {
            if animateItemsSequentially {
                _VariadicView.Tree(ItemIndexer(visibleItems: visibleItems, springResponse: springResponse, springDamping: springDamping)) {
                    content
                }
            } else {
                content
            }
        }
        
        private func animateItemsOneByOne() {
            // Count items first
            _VariadicView.Tree(ItemCounter(count: $itemCount)) {
                content
            }
            
            // Animate each item with staggered delay
            for index in 0..<itemCount {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * itemDelay) {
                    visibleItems.insert(index)
                }
            }
        }
    }
    
    // MARK: - Item Counter
    private struct ItemCounter: _VariadicView_UnaryViewRoot {
        @Binding var count: Int
        
        func body(children: _VariadicView.Children) -> some View {
            DispatchQueue.main.async {
                count = children.count
            }
            return EmptyView()
        }
    }
    
    // MARK: - Item Indexer (Adds animation to each item)
    private struct ItemIndexer: _VariadicView_UnaryViewRoot {
        let visibleItems: Set<Int>
        let springResponse: Double
        let springDamping: Double
        
        @ViewBuilder
        func body(children: _VariadicView.Children) -> some View {
            ForEach(Array(children.enumerated()), id: \.offset) { index, child in
                child
                    .scaleEffect(visibleItems.contains(index) ? 1.0 : 0.01)
                    .opacity(visibleItems.contains(index) ? 1.0 : 0)
                    .animation(.spring(response: springResponse, dampingFraction: springDamping), value: visibleItems)
            }
        }
    }

    // MARK: - Legacy Arc Layout (iOS 15)
    private struct ArcLayoutLegacy: _VariadicView_UnaryViewRoot {
        var radius: CGFloat
        var startAngle: Angle
        var arcAngle: Angle
        var tiltFactor: CGFloat
        var visibleItems: Set<Int>
        
        @ViewBuilder
        func body(children: _VariadicView.Children) -> some View {
            ZStack {
                ForEach(Array(children.enumerated()), id: \.offset) { index, child in
                    child
                        .position(positionFor(index: index, count: children.count))
                }
            }
            .frame(width: radius * 2,
                   height: radius * (1 - cos(arcAngle.radians / 2)) * 2 * tiltFactor)
        }
        
        private func positionFor(index: Int, count: Int) -> CGPoint {
            let angleStep = count > 1 ? arcAngle.radians / Double(count - 1) : 0
            let angle = startAngle.radians + (angleStep * Double(index))
            let x = radius + radius * cos(angle)
            let y = radius + radius * sin(angle) * tiltFactor
            return CGPoint(x: x, y: y)
        }
    }
}

// MARK: - View Extension
extension View {
    /// Arranges views in an arc pattern, with optional tilt (flattening)
    func arcLayout(radius: CGFloat = 120,
                   startAngle: Angle = .degrees(180),
                   arcAngle: Angle = .degrees(180),
                   tiltFactor: CGFloat = 1.0,
                   isAnimate: Bool = false,
                   animateItemsSequentially: Bool = false,
                   itemDelay: Double = 0.1,
                   springResponse: Double = 0.6,
                   springDamping: Double = 0.7) -> some View {
        CustomViewLayout.ArcLayoutContainer(
            radius: radius,
            startAngle: startAngle,
            arcAngle: arcAngle,
            tiltFactor: tiltFactor,
            isAnimate: isAnimate,
            animateItemsSequentially: animateItemsSequentially,
            itemDelay: itemDelay,
            springResponse: springResponse,
            springDamping: springDamping
        ) {
            self
        }
    }
}

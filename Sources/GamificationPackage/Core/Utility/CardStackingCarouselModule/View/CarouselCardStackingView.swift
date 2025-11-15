//
//  CarouselCardStackingView.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 12/11/25.
//  Copyright © 2025 EnthrallTech. All rights reserved.
//

import SwiftUI

struct CarouselStackingView<Item: Identifiable, CardContent: View, PrevButton: View, NextButton: View>: View {
    
    let items: [Item]
    @Binding var index: Int
    
    let cardContent: (Item) -> CardContent
    let previousButton: () -> PrevButton
    let nextButton: () -> NextButton
    
    @GestureState private var dragTranslation: CGFloat = 0
    
    // MARK: - FULL INITIALIZER (custom buttons supplied)
    init(
        items: [Item],
        index: Binding<Int>,
        @ViewBuilder previousButton: @escaping () -> PrevButton,
        @ViewBuilder nextButton: @escaping () -> NextButton,
        @ViewBuilder cardContent: @escaping (Item) -> CardContent
    ) {
        self.items = items
        self._index = index
        self.previousButton = previousButton
        self.nextButton = nextButton
        self.cardContent = cardContent
    }
    
    // MARK: - SIMPLE INITIALIZER (default buttons used)
    init(
        items: [Item],
        index: Binding<Int>,
        @ViewBuilder cardContent: @escaping (Item) -> CardContent
    ) where PrevButton == CardStackingDefaultButtonView, NextButton == CardStackingDefaultButtonView {
        self.items = items
        self._index = index
        self.previousButton = { CardStackingDefaultButtonView(system: "chevron.left") }
        self.nextButton = { CardStackingDefaultButtonView(system: "chevron.right") }
        self.cardContent = cardContent
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    
                    ZStack {
                        ForEach(visibleIndices(), id: \.self) { i in
                            let r = i - index
                            
                            cardContent(items[i])
                                .frame(
                                    width: geo.size.width * 0.42,
                                    height: geo.size.height * 0.65
                                )
                                .scaleEffect(r == 0 ? 1.08 : 0.88)
                                .offset(
                                    x: xOffset(r) + dragOffset(r),
                                    y: 0
                                )
                                .blur(radius: r == 0 ? 0 : 2)
                                .zIndex(zIndex(r))
                                .animation(.easeInOut(duration: 0.30), value: index)
                        }
                    }
                    .contentShape(Rectangle())
                    .gesture(dragGesture())
                    
                    Spacer(minLength: 0)
                }
                
                previousButton()
                    .opacity(index > 0 ? 1 : 0.3)
                    .onTapGesture { moveLeft() }
                    .offset(x: -geo.size.width * 0.44)
                
                nextButton()
                    .opacity(index < items.count - 1 ? 1 : 0.3)
                    .onTapGesture { moveRight() }
                    .offset(x: geo.size.width * 0.44)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}


// MARK: - LOGIC EXTENSIONS
extension CarouselStackingView {
    
    private func visibleIndices() -> [Int] {
        var arr = [Int]()
        if index > 0 { arr.append(index - 1) }
        arr.append(index)
        if index < items.count - 1 { arr.append(index + 1) }
        return arr
    }
    
    private func xOffset(_ r: Int) -> CGFloat {
        r == 0 ? 0 : (r < 0 ? -140 : 140)
    }
    
    private func dragOffset(_ r: Int) -> CGFloat {
        r == 0 ? dragTranslation : dragTranslation * 0.25
    }
    
    private func zIndex(_ r: Int) -> Double {
        r == 0 ? 10 : (r > 0 ? 5 : 4)
    }
    
    private func moveLeft() { if index > 0 { index -= 1 } }
    private func moveRight() { if index < items.count - 1 { index += 1 } }
    
    private func dragGesture() -> some Gesture {
        DragGesture()
            .updating($dragTranslation) { value, state, _ in
                state = value.translation.width
            }
            .onEnded { value in
                let drag = value.predictedEndTranslation.width
                let threshold: CGFloat = 120
                
                if drag < -threshold { moveRight() }
                else if drag > threshold { moveLeft() }
            }
    }
}







//-- Preview ---

// MARK: - DEMO


private struct DemoView: View {
    
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
        VStack {
            CarouselStackingView(items: data, index: $index) { item in
                
                RoundedRectangle(cornerRadius: 28)
                    .fill(item.color)
                    .overlay(
                        Text(item.title)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                    )
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    DemoView()
}

//
//  DynamicGridByScreenWidthWrapper.swift
//  Ujjivan
//
//  Created by Kashif Hussain on 26/12/24.
//  Copyright © 2024 EnthrallTech. All rights reserved.
//

import SwiftUI

/// A generic dynamic grid view that adapts the number of columns based on screen width and a minimum item width.
///
/// This view takes a collection of items and a content closure to render each item in a responsive grid.
/// The grid layout adjusts dynamically to fit as many items as possible in a row while respecting the minimum width.
struct DynamicGridByScreenWidthWrapper<T: RandomAccessCollection, Content: View>: View where T.Element: Hashable {
    
    // MARK: - Properties
    
    /// The collection of items to display in the grid.
    let items: T
    
    /// The minimum width for each item in the grid.
    let minimumWidth: CGFloat
    
    /// A closure that generates the content view for each item.
    let content: (T.Element) -> Content
    
    // MARK: - Initializer
    
    /// Initializes a `DynamicGridByScreenWidth` with the provided items, minimum width, and content closure.
    ///
    /// - Parameters:
    ///   - items: The collection of items to display in the grid. Must conform to `RandomAccessCollection` and its elements must be `Hashable`.
    ///   - minimumWidth: The minimum width for each grid item. Determines how many items fit in a row.
    ///   - content: A closure that generates the content view for each item in the grid.
    init(items: T, minimumWidth: CGFloat, @ViewBuilder content: @escaping (T.Element) -> Content) {
        self.items = items
        self.minimumWidth = minimumWidth
        self.content = content
    }
    
    // MARK: - Body
    
    var body: some View {
        // Define the grid layout using an adaptive column configuration.
        let columns = [
            GridItem(.adaptive(minimum: minimumWidth), spacing: 10)
        ]
        
        // Create a lazy vertical grid to display the items.
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(items, id: \.self) { item in
                content(item)
            }
        }
        .padding(.horizontal)
    }
}


// MARK: - Preview
#Preview {
    // Example usage of DynamicGridByScreenWidth with a list of strings.
    let items = ["Apple", "Banana", "Cherry"]
    return DynamicGridByScreenWidthWrapper(items: items, minimumWidth: 100) { item in
        Text(item)
            .font(.headline)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.7))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

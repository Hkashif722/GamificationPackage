//
//  SwiftUIUtility.swift
//  GamificationPackage
//
//  Created by Kashif Hussain on 14/11/25.
//

import SwiftUI


internal struct SwiftUIUtility {
    
    struct BackgroundImageView: View {
        let imageName: String
        var contentMode: ContentMode = .fit
        
        var body: some View {
            Image(imageName, bundle: .module)
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
    
    // MARK: - Gradient Divider Utility
    struct GradientDivider: View {
        let colors: [Color]
        let height: CGFloat
        let startPoint: UnitPoint
        let endPoint: UnitPoint
        let horizontalPadding: CGFloat
        
        init(
            colors: [Color] = [.white.opacity(0.1), .white.opacity(0.9), .white.opacity(0.1)],
            height: CGFloat = 2,
            startPoint: UnitPoint = .leading,
            endPoint: UnitPoint = .trailing,
            horizontalPadding: CGFloat = 2
        ) {
            self.colors = colors
            self.height = height
            self.startPoint = startPoint
            self.endPoint = endPoint
            self.horizontalPadding = horizontalPadding
        }
        
        var body: some View {
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: startPoint,
                endPoint: endPoint
            )
            .frame(height: height)
            .padding(.horizontal, horizontalPadding)
        }
    }
    
    struct RoundMenuButton: View  {
        
        enum RoundMenuButtonImage {
            case system(name: String)
            case asset(name: String)
        }
        
        // Use our enum to support both image types
        var image: RoundMenuButtonImage
        
        var buttonSize: CGFloat = 80
        var imagePadding: CGFloat = 15
        var foregroundColor: Color = .black
        var backgroundColor: Color = Color(.systemBackground)
        var shadowColor: Color = Color.gray.opacity(0.4)
        var shadowRadius: CGFloat = 5
        var isAnimating: Bool = false
        
        // Action closure for the button
        var action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Circle()
                    .foregroundColor(.clear)
                    .frame(width: buttonSize, height: buttonSize)
                    .background(backgroundColor)
                    .clipShape(Circle())
                    .shadow(color: shadowColor, radius: shadowRadius)
                    .overlay(
                        Group {
                            switch image {
                            case .system(let name):
                                Image(systemName: name)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(foregroundColor)
                                    .padding(imagePadding)
                            case .asset(let name):
                                Image(name, bundle: .module)
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(imagePadding)
                            }
                        }
                        
                    )
                    .padding(10)
                    .clipShape(Circle())
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    

    struct ProfileImageViewWithGradientBorder: View {
        let imageUrl: URL?
        let size: CGFloat
        var gradientColors: [Color] = [.blue, .purple]
        var borderWidth: CGFloat = 2
        var placeHolderImageUrlString: String =
            "https://content.gogetempowered.com/assets/img/Thumbnail_vectors/img_thumb60.jpg"
        
        var placeholder: some View {
            AsyncImage(url: URL(string: placeHolderImageUrlString)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2) // backup placeholder
            }
        }

        var body: some View {
            AsyncImage(url: imageUrl) { phase in
                
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure(_):
                    placeholder
                    
                case .empty:
                    placeholder
                    
                @unknown default:
                    placeholder
                }
                
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(
                    LinearGradient(
                        colors: gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: borderWidth
                )
            )
        }
    }


    struct ProfileImageViewWithVariableCorner: View {
        let imageUrl: URL?
        let size: CGFloat
        let cornerRadius: CGFloat
        var profileBorderColor: Color? = nil
        var borderWidth: CGFloat
        var placeHolderImageUrlString: String
        
        init(
            imageUrl: URL?,
            size: CGFloat,
            cornerRadius: CGFloat = 10,
            profileBorderColor: Color? = nil,
            borderWidth: CGFloat = 2,
            placeHolderImageUrlString: String =
                "https://content.gogetempowered.com/assets/img/Thumbnail_vectors/img_thumb60.jpg"
        ) {
            self.imageUrl = imageUrl
            self.size = size
            self.cornerRadius = cornerRadius
            self.profileBorderColor = profileBorderColor
            self.borderWidth = borderWidth
            self.placeHolderImageUrlString = placeHolderImageUrlString
        }
        
        // Placeholder view (remote placeholder image)
        private var placeholderView: some View {
            AsyncImage(url: URL(string: placeHolderImageUrlString)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
        }
        
        var body: some View {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure(_):
                    placeholderView
                    
                case .empty:
                    placeholderView
                    
                @unknown default:
                    placeholderView
                }
            }
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        profileBorderColor ?? .clear,
                        lineWidth: profileBorderColor != nil ? borderWidth : 0
                    )
            )
        }
    }
    
    
    struct RectangularGradientButton: View {
        var title: String? = nil
        var iconName: String? = nil
        var isSystemIcon: Bool = true
        var gradient: LinearGradient
        var foregroundColor: Color = .white
        var borderColor: Color? = nil
        var borderWidth: CGFloat = 1.5
        var cornerRadius: CGFloat = 10
        var height: CGFloat = 50
        var font: Font = .headline
        var action: () -> Void

        var body: some View {
            Button(action: action) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(gradient)
                    .frame(height: height)
                    .overlay {
                        if let borderColor = borderColor {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(borderColor, lineWidth: borderWidth)
                        }
                    }
                    .overlay {
                        HStack(spacing: 8) {
                            if let iconName = iconName {
                                (isSystemIcon
                                 ? Image(systemName: iconName)
                                 : Image(iconName, bundle: .module))
                                .foregroundStyle(foregroundColor)
                            }

                            if let title = title {
                                Text(title)
                                    .font(font)
                                    .foregroundStyle(foregroundColor)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.3)
                                    .allowsTightening(true)
                            }
                        }
                        .padding(5)
                    }
            }
            .font(font)
        }
    }
    
    struct RectangularIconButtonWithBorder: View {
        var title: String? = nil
        var iconName: String? = nil
        var isSystemIcon: Bool = true
        var backgroundColor: SwiftUI.Color = .clear
        var foregroundColor: Color = ColorUtility.primaryColor
        var borderColor: Color = ColorUtility.primaryColor
        var borderWidth: CGFloat = 1.5
        var cornerRadius: CGFloat = 10
        var height: CGFloat = 50
        var font: Font = .headline
        var action: () -> Void
        
        var body: some View {
            Button(action: action) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .frame(height: height)
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor, lineWidth: borderWidth)
                    }
                    .overlay {
                        HStack(spacing: 8) {
                            if let iconName = iconName {
                                (isSystemIcon
                                 ? Image(systemName: iconName)
                                 : Image(iconName,bundle: .module))
                                .foregroundStyle(foregroundColor)
                            }
                            if let title = title {
                                Text(title)
                                    .minimumScaleFactor(0.7)
                                    .foregroundStyle(foregroundColor)
                            }
                        }
                        .padding(.all, 5)
                        .padding(.horizontal, 5)
                    }
            }
            .font(font)
        }
    }
    
    
    struct CircularProgressView: View {
        /// A value between 0.0 and 1.0.
        var progress: Double
        /// The line width for the progress circle.
        var lineWidth: CGFloat = 10.0
        /// The size of the circular progress view.
        var size: CGFloat = 100.0
        /// Optional gradient colors. If nil, uses solid color.
        var gradientColors: [Color]?
        /// Solid color used when gradientColors is nil.
        var solidColor: Color = ColorUtility.primaryColor
        /// Show or hide percentage text.
        var showPercentage: Bool = true
        /// Custom text color. If nil, uses .primary.
        var textColor: Color?
        /// Custom font for percentage text.
        var font: Font = .headline
        
        
        /// Creates a circular progress view with gradient colors.
        init(
            progress: Double,
            gradientColors: [Color]? = nil,
            lineWidth: CGFloat = 10.0,
            size: CGFloat = 100.0,
            showPercentage: Bool = true,
            textColor: Color? = nil,
            font: Font = .headline
        ) {
            self.progress = progress
            self.gradientColors = gradientColors
            self.lineWidth = lineWidth
            self.size = size
            self.showPercentage = showPercentage
            self.textColor = textColor
            self.font = font
        }
        
        var body: some View {
            ZStack {
                // Background track circle
                Circle()
                    .stroke(
                        backgroundStroke,
                        lineWidth: lineWidth
                    )
                    .frame(width: size, height: size)
                
                // Progress circle
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        progressStroke,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .rotationEffect(gradientColors != nil ? .degrees(-85) : .degrees(-90))
                    .frame(width: size, height: size)
                    .animation(.linear, value: progress)
                
                // Center text showing percentage
                if showPercentage {
                    Text(String(format: "%.0f%%", progress * 100))
                        .font(font)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(textColor ?? .primary)
                }
            }
        }
        
        // MARK: - Computed Properties
        
        private var backgroundStroke: some ShapeStyle {
            if let gradientColors = gradientColors {
                return AnyShapeStyle(
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ).opacity(0.2)
                )
            } else {
                return AnyShapeStyle(Color.gray.opacity(0.3))
            }
        }

        private var progressStroke: some ShapeStyle {
            if let gradientColors = gradientColors {
                return AnyShapeStyle(
                    AngularGradient(
                        gradient: Gradient(colors: gradientColors),
                        center: .center,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(355)
                    )
                )
            } else {
                return AnyShapeStyle(solidColor)
            }
        }

    }
    
    
    struct IconWithText: View {
        var imageName: String
        var imageSize: CGSize
        var text: String
        var isSystemImage: Bool = true
        var isSelectionType: Bool = false
        var font: Font = .body
        var iconColor: Color = .primary
        var textColor: Color = .primary
        var spacing: CGFloat = 8
        var rendringMode: Image.TemplateRenderingMode? = .template

        let onTap: (() -> ())?

        init(
            imageName: String,
            imageSize: CGSize = CGSize(width: 24, height: 24),
            text: String,
            isSystemImage: Bool = true,
            isSelectionType: Bool = false,
            font: Font = .body,
            iconColor: Color = .primary,
            textColor: Color = .primary,
            spacing: CGFloat = 8,
            rendringMode: Image.TemplateRenderingMode? = nil,
            onTap: (() -> Void)? = nil
        ) {
            self.imageName = imageName
            self.imageSize = imageSize
            self.text = text
            self.isSystemImage = isSystemImage
            self.isSelectionType = isSelectionType
            self.font = font
            self.iconColor = iconColor
            self.textColor = textColor
            self.spacing = spacing
            self.rendringMode = rendringMode
            self.onTap = onTap
        }

        var body: some View {
            HStack(spacing: spacing) {
                if isSystemImage {
                    Image(systemName: imageName)
                        .foregroundColor(iconColor)
                        .font(font)
                } else {
                    Image(imageName, bundle: .module)
                        .resizable()
                        .renderingMode(rendringMode)
                        .scaledToFit()
                        .frame(width: imageSize.width, height: imageSize.height)
                        .foregroundColor(iconColor)
                }

                Text(text)
                    .foregroundColor(textColor)
                    .font(font)
                    .lineLimit(1)
                    .minimumScaleFactor(0.3)
                    .allowsTightening(true)

                if isSelectionType {
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onTap?()
            }
        }
    }

    
    // MARK: - Profile Image View
    struct ProfileImageView: View {
        let imageUrl: URL?
        let size: CGFloat
        var profileBorderColor: SwiftUI.Color? = nil
        var borderWidth: CGFloat = 2
        var placeHolderImageUrlString: String =
            "https://content.gogetempowered.com/assets/img/Thumbnail_vectors/img_thumb60.jpg"
        
        var body: some View {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    AsyncImage(url: URL(string: placeHolderImageUrlString)) { imgPhase in
                        (imgPhase.image ?? Image(systemName: "person.circle"))
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(profileBorderColor ?? .clear,
                                lineWidth: profileBorderColor != nil ? borderWidth : 0)
            )
        }
    }

    
}

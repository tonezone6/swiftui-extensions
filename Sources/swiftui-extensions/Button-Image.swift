//
//  SwiftUIView.swift
//  
//
//  Created by Alex S. on 06/11/2022.
//

import SwiftUI

extension Button where Label == ButtonImageLabel {
    public init(
        _ title: String,
        image: Image? = nil,
        position: ButtonImageLabel.Position = .left,
        loading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.init(action: action) {
            ButtonImageLabel(
                title: title,
                image: image,
                position: position,
                loading: loading
            )
        }
    }
}

///
/// Reusable button label
/// displaying a left or right image and a loading indicator
///
public struct ButtonImageLabel: View {
    public enum Position {
        case left, right
    }
    
    let title: String
    let image: Image?
    let position: Position
    let loading: Bool
    
    public var body: some View {
        HStack(spacing: 8) {
            if loading {
                ProgressView()
            } else if let image = image, position == .left {
                image
            }
            
            Text(title)
            
            if let image = image, position == .right {
                image
            }
        }
        .animation(.spring(), value: loading)
    }
    
    public init(
        title: String,
        image: Image? = nil,
        position: Position = .left,
        loading: Bool = false
    ) {
        self.title = title
        self.image = image
        self.position = position
        self.loading = loading
    }
}

// MARK: Preview

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Favorites", image: .heartFill, position: .left) {}
            Button("Upload", image: .arrowUp, position: .right) {}
            Button("Loading", loading: true) {}
                .disabled(true)
        }
        .padding()
        .buttonStyle(.mint)
    }
}

// MARK: Preview helpers

private extension Image {
    static let heartFill = Image(systemName: "heart.fill")
    static let arrowUp = Image(systemName: "arrow.up")
}

private extension ButtonStyle where Self == MintButtonStyle {
    static var mint: MintButtonStyle {
        MintButtonStyle()
    }
}

private struct MintButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var enabled: Bool
                
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .tint(.white) // progress view
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.mint))
            .disabled(!enabled)
            .opacity((configuration.isPressed || !enabled) ? 0.7 : 1.0)
            .contentShape(Rectangle())
    }
}

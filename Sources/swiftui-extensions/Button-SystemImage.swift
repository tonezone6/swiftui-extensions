//
//  Button-SystemImage.swift
//

import SwiftUI

extension Button where Label == ButtonLabel {
  public init(
    _ title: LocalizedStringKey,
    systemImage: String? = nil,
    position: ButtonLabel.ImagePosition = .trailing,
    loading: Bool = false,
    action: @escaping () -> Void
  ) {
    self.init(action: action) {
      ButtonLabel(
        title: title,
        systemImage: systemImage,
        position: position,
        loading: loading
      )
    }
  }
}

public struct ButtonLabel: View {
  public let title: LocalizedStringKey
  public let systemImage: String?
  public let position: ImagePosition
  public let loading: Bool
  
  public enum ImagePosition {
    case leading, trailing
  }
  
  public init(
    title: LocalizedStringKey,
    systemImage: String? = nil,
    position: ImagePosition,
    loading: Bool = false
  ) {
    self.title = title
    self.systemImage = systemImage
    self.position = position
    self.loading = loading
  }
  
  public var body: some View {
    Group {
      if position == .leading {
        Label(title: { Text(title) }, icon: createIcon)
          .labelStyle(LeadingIconLabelStyle())
      } else {
        Label(title: { Text(title) }, icon: createIcon)
          .labelStyle(TrailingIconLabelStyle())
      }
    }
  }
  
  @ViewBuilder
  private func createIcon() -> some View {
    if loading {
      ProgressView()
    } else if let systemImage = systemImage {
      Image(systemName: systemImage)
        .fontWeight(.heavy)
    } else {
      EmptyView()
    }
  }
}

struct LeadingIconLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: 8) {
      configuration.icon
      configuration.title
    }
  }
}

struct TrailingIconLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: 8) {
      configuration.title
      configuration.icon
    }
  }
}

public struct RoundedRectButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled: Bool
  
  public let foregroundColor: Color
  public let backgroundColor: Color
  public let cornerRadius: CGFloat
  
  public init(
    foregroundColor: Color,
    backgroundColor: Color,
    cornerRadius: CGFloat
  ) {
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
    self.cornerRadius = cornerRadius
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    let isTransparent = !isEnabled || configuration.isPressed
    configuration.label
      .font(.headline)
      .frame(maxWidth: .infinity)
      .padding()
      .foregroundColor(foregroundColor)
      .tint(foregroundColor) // progress view
      .background(
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(backgroundColor.gradient)
      )
      .disabled(!isEnabled)
      .opacity(isTransparent ? 0.7 : 1.0)
      .contentShape(Rectangle())
  }
}

private extension ButtonStyle where Self == RoundedRectButtonStyle {
  static var roundedBlueRect: RoundedRectButtonStyle {
    RoundedRectButtonStyle(
      foregroundColor: .white,
      backgroundColor: .blue,
      cornerRadius: 8
    )
  }
}

#Preview {
  VStack {
    Button("Continue") {}
    Button("Favorites", systemImage: "heart.fill", position: .leading) {}
    Button("Upload", systemImage: "arrow.up", position: .trailing) {}
    Button("Loading", position: .leading, loading: true) {}
      .disabled(true)
  }
  .buttonStyle(.roundedBlueRect)
  .padding()
}

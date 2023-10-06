//
//  ButtonStyle-Rounded.swift
//

import SwiftUI

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

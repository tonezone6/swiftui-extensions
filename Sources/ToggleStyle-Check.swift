//
//  ToggleStyle-Check.swift
//

import SwiftUI

extension ToggleStyle where Self == SystemImageToggleStyle {
  public static var checkCircle: Self {
    SystemImageToggleStyle(
      onImage: "checkmark.circle.fill",
      offImage: "circle"
    )
  }
  
  public static var checkSquare: Self {
    SystemImageToggleStyle(
      onImage: "checkmark.square.fill",
      offImage: "square"
    )
  }
}

public struct SystemImageToggleStyle: ToggleStyle {
  public let onImage: String
  public let offImage: String
  public let color: Color
  
  public init(
    onImage: String,
    offImage: String,
    color: Color = .accentColor
  ) {
    self.onImage = onImage
    self.offImage = offImage
    self.color = color
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()
      Button {
        configuration.isOn.toggle()
      } label: {
        Image(systemName: configuration.isOn ? onImage : offImage)
          .foregroundColor(configuration.isOn ? color : .secondary)
          .accessibilityLabel(Text(configuration.isOn ? "Checked" : "Unchecked"))
          .imageScale(.large)
      }
    }
  }
}

struct ToggleView: View {
  @State private var showMore = false
  
  var body: some View {
    Toggle("Show more options", isOn: $showMore)
  }
}

#Preview {
  Form {
    ToggleView()
    ToggleView().toggleStyle(.checkCircle)
    ToggleView().toggleStyle(.checkSquare)
  }
}

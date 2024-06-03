//
//  SwiftUIView.swift
//
//
//  Created by Alex S. on 03.06.2024.
//

import SwiftUI

@available(iOS 17.0, *)
struct ScrollIfNecessary: ViewModifier {
  let axis: Axis.Set
  func body(content: Content) -> some View {
    ViewThatFits {
      content
      ScrollView(axis) {
        content
      }
      .contentMargins(axis == .vertical ? .trailing : .bottom, -10, for: .scrollIndicators)
      .contentMargins(axis == .vertical ? .bottom : .trailing, 10, for: .scrollContent)
    }
  }
}

@available(iOS 17.0, *)
extension View {
  public func scrollIfNecessary(axis: Axis.Set = .vertical) -> some View  {
    modifier(ScrollIfNecessary(axis: axis))
  }
}

//
//  Shape-Fill.swift
//

import SwiftUI

extension Shape {
  ///
  /// Combine both fill and stroke in one modifier
  ///
  public func fill<A, B>(
    _ fillStyle: A,
    stroke strokeStyle: B,
    lineWidth: Double = 1
  ) -> some View where A : ShapeStyle, B : ShapeStyle {
    stroke(strokeStyle, lineWidth: lineWidth)
      .background(fill(fillStyle))
  }
}

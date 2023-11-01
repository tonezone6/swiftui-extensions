//
//  Shape-Fill.swift
//

import SwiftUI

extension Shape {
  ///
  /// Combine both fill and stroke in one modifier
  ///
  public func fill<Fill, Stroke>(
    _ fillStyle: Fill,
    stroke strokeStyle: Stroke,
    lineWidth: Double = 1
  ) -> some View where Fill: ShapeStyle, Stroke: ShapeStyle {
    self.stroke(strokeStyle, lineWidth: lineWidth)
      .background(self.fill(fillStyle))
  }
}

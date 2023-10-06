//
//  Layout-FlowStack.swift
//  

import SwiftUI

public struct FlowStack: Layout {
  let spacing: CGFloat
  
  public init(spacing: CGFloat = 4) {
    self.spacing = spacing
  }
  
  public func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout ()
  ) -> CGSize {
    let containerWidth = proposal.replacingUnspecifiedDimensions().width
    let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    let layoutSize = layout(sizes, spacing, containerWidth).size
    return layoutSize
  }
  
  public func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout ()
  ) {
    let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    let layoutOffsets = layout(sizes, spacing, bounds.width).offsets
    for (offset, subview) in zip(layoutOffsets, subviews) {
      subview.place(
        at: CGPoint(
          x: offset.x + bounds.minX,
          y: offset.y + bounds.minY
        ),
        proposal: .unspecified
      )
    }
  }
  
  func layout(
    _ sizes: [CGSize],
    _ spacing: CGFloat,
    _ containerWidth: CGFloat
  ) -> (offsets: [CGPoint], size: CGSize) {
    var offsets: [CGPoint] = []
    var currentPosition: CGPoint = .zero
    var lineHeight: CGFloat = 0
    var maxX: CGFloat = 0
    
    for size in sizes {
      if currentPosition.x + size.width > containerWidth {
        currentPosition.x = 0
        currentPosition.y += lineHeight + spacing
        lineHeight = 0
      }
      offsets.append(currentPosition)
      currentPosition.x += size.width
      maxX = max(maxX, currentPosition.x)
      currentPosition.x += spacing
      lineHeight = max(lineHeight, size.height)
    }
    return (
      offsets,
      CGSize(width: maxX, height: currentPosition.y + lineHeight)
    )
  }
}

#Preview {
  ScrollView {
    FlowStack {
      let items = String.loremIpsum(words: 50)!
      ForEach(items.uniqueStrings(), id: \.self) { string in
        Text(string)
          .padding(6)
          .padding(.horizontal, 6)
          .foregroundStyle(.white)
          .background(.blue.gradient)
          .clipShape(.capsule)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
  }
}

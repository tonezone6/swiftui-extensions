//
//  View-OverlaySize.swift
//

import SwiftUI

extension View {
  public func overlaySize() -> some View {
    self.overlay(alignment: .center) {
      GeometryReader { proxy in
        VStack {
          Spacer()
          HStack {
            Spacer()
            Text(
              proxy.size.width.formatted() + ", " +
              proxy.size.height.formatted()
            )
            .padding(4)
            .background(.black)
            .foregroundStyle(.white)
            .fixedSize()
            Spacer()
          }
          Spacer()
        }
        .background(Stripes())
      }
    }
  }
}

struct Stripes: View {
  var background: Color = .clear
  var foreground: Color = .red
  var degrees: Double = 45
  var barWidth: CGFloat = 1
  var barSpacing: CGFloat = 6
  
  public var body: some View {
    GeometryReader { geometry in
      let longSide = max(geometry.size.width, geometry.size.height)
      let itemWidth = barWidth + barSpacing
      let items = Int(2 * longSide / itemWidth)
      HStack(spacing: barSpacing) {
        ForEach(0..<items, id: \.self) { index in
          foreground.frame(width: barWidth, height: 2 * longSide)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .rotationEffect(Angle(degrees: degrees), anchor: .center)
      .offset(x: -longSide / 2, y: -longSide / 2)
      .background(background)
    }
    .clipped()
  }
}

#Preview {
  VStack(spacing: 0) {
    Rectangle().fill(.mint)
    Rectangle().fill(.brown)
    Rectangle().fill(.red)
    Rectangle().fill(.orange)
    Rectangle().fill(.yellow)
    Rectangle().fill(.cyan).overlaySize()
    Rectangle().fill(.teal)
    Rectangle().fill(.blue)
  }
  .ignoresSafeArea()
}


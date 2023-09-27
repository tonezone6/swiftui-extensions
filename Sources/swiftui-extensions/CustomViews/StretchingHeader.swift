//
//  SwiftUIView.swift
//  
//
//  Created by Alex S. on 27/09/2023.
//

import SwiftUI

public struct StretchingHeader<Content>: View where Content: View {
  public let spacing: CGFloat
  public let content: () -> Content
  
  public var body: some View {
    GeometryReader { proxy in
      VStack(spacing: spacing, content: content)
        .frame(width: proxy.size.width, height: proxy.stretchingHeight)
        .offset(y: proxy.stretchingOffset)
    }
  }
  
  public init(
    spacing: CGFloat = 8,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.spacing = spacing
    self.content = content
  }
}

private extension GeometryProxy {
  var stretchingHeight: CGFloat {
    let y = self.frame(in: .global).minY
    return self.size.height + max(0, y)
  }
  
  var stretchingOffset: CGFloat {
    let y = self.frame(in: .global).minY
    return min(0, -y)
  }
}

#Preview {
  ScrollView {
    StretchingHeader {
      Color.mint
      Text("Mint stretching header")
    }
    .frame(height: 300)
  }
  .ignoresSafeArea()
}



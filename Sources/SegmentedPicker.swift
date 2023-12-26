//
//  SegmentedPicker.swift
//

import SwiftUI

public struct SegmentedPicker<Value, Content>: View 
where Value : Hashable, Content : View  {
  
  public let values: [Value]
  @Binding public var selection: Value
  public let content: (Value) -> Content
  
  @Namespace private var namespace
  private let namespaceID = "active_segment"
  
  public init(
    _ values: [Value],
    selection: Binding<Value>,
    content: @escaping (Value) -> Content
  ) {
    self.values = values
    self._selection = selection
    self.content = content
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      ForEach(values, id: \.self) { value in
        content(value)
          .background {
            if value == selection {
              Capsule()
                .fill(.primary.opacity(0.1))
                .matchedGeometryEffect(id: namespaceID, in: namespace)
            }
          }
          .animation(.snappy(duration: 0.2), value: selection)
          .contentShape(.rect)
          .onTapGesture {
            selection = value
          }
      }
    }
    .padding(5)
    .background(.secondary.opacity(0.1), in: .capsule)
  }
}

struct SegmentedPickerWrapper: View  {
  @State private var selection: Theme = .light
  
  enum Theme: String, CaseIterable {
    case `default` = "Default"
    case light = "Light"
    case dark = "Dark"
  }
  
  var body: some View {
    SegmentedPicker(Theme.allCases, selection: $selection) { theme in
      Text(theme.rawValue)
        .fontWeight(.medium)
        .padding(.vertical, 10)
        .frame(width: 100)
    }
  }
}

#Preview {
  SegmentedPickerWrapper()
}

//
//  View-NavigationAppearence.swift
//

import SwiftUI

extension View {
  public func navigationBar(
    backgroundColor: UIColor,
    foregroundColor: UIColor,
    tintColor: UIColor? = nil,
    backSystemImage: String? = nil,
    hideSeparator: Bool = false
  ) -> some View {
    self.modifier(
      NavigationStackViewModifier(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        tintColor: tintColor,
        backSystemImage: backSystemImage,
        hideSeparator: hideSeparator
      )
    )
  }
}

extension UINavigationController {
  /// ⚠️ Warning
  /// by extending the navigation controller like this,
  /// back button text will always be hidden.
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    navigationBar.topItem?.backButtonDisplayMode = .minimal
  }
}

struct NavigationStackViewModifier: ViewModifier {
  let tintColor: Color?
  
  init(
    backgroundColor: UIColor,
    foregroundColor: UIColor,
    tintColor: UIColor?,
    backSystemImage: String?,
    hideSeparator: Bool
  ) {
    let appearance = UINavigationBarAppearance()
    appearance.titleTextAttributes = [.foregroundColor : foregroundColor]
    appearance.largeTitleTextAttributes = [.foregroundColor : foregroundColor]
    appearance.backgroundColor = backgroundColor
    
    if let systemName = backSystemImage {
      let config = UIImage.SymbolConfiguration(weight: .semibold)
      let image = UIImage(systemName: systemName, withConfiguration: config)
      appearance.setBackIndicatorImage(image, transitionMaskImage: image)
    }
    
    if hideSeparator {
      appearance.shadowColor = .clear
    }
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    
    ///
    /// ⚠️ not working in later SwiftUI versions
    ///
    /// if let tintColor {
    ///    UINavigationBar.appearance().tintColor = tintColor
    /// }
    
    if let tintColor {
      self.tintColor = Color(uiColor: tintColor)
    } else {
      self.tintColor = nil
    }
  }
  
  func body(content: Content) -> some View {
    content
      .tint(tintColor)
  }
}

struct ContentView: View {
  var body: some View {
    List(1...30, id: \.self) { index in
      NavigationLink {
        Text(index.formatted(.number))
          .font(.largeTitle)
          .navigationBarTitleDisplayMode(.inline)
          .navigationTitle("\(index)")
      } label: {
        Text("\(index)")
      }
    }
    .listStyle(.plain)
    .toolbar {
      Button("Add") {}
    }
  }
}

#Preview {
  ContentView()
    .navigationTitle("Numbers")
    .navigationBarTitleDisplayMode(.inline)
    .navigationStack()
    .tint(.white)
    .navigationBar(
      backgroundColor: .systemTeal,
      foregroundColor: .white,
      backSystemImage: "arrow.left",
      hideSeparator: true
    )
}

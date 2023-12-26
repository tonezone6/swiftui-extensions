//
// View-NavigationStack.swift
//

import SwiftUI

extension View {
  public func navigationStack() -> some View {
    NavigationStack { self }
  }
  
  public func navigationStack<A>(
    path: Binding<[A]>
  ) -> some View where A : Hashable {
    NavigationStack(path: path) { self }
  }
  
  public func navigationStack<A, B>(
    path: Binding<[A]>,
    @ViewBuilder destination: @escaping (A) -> B
  ) -> some View where A : Hashable, B : View {
    NavigationStack(path: path) {
      self.navigationDestination(for: A.self, destination: destination)
    }
  }
}

#Preview {
  Text("Text embeded in a navigation stack")
    .navigationTitle("Navigation")
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(.visible, for: .navigationBar)
    .navigationStack()
}

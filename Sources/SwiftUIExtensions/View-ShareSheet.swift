//
//  View-ShareSheet.swift
//

import SwiftUI
import UIKit

extension View {
  public func shareSheet(
    isPresented: Binding<Bool>,
    items: [Any],
    activities: [UIActivity]? = nil
  ) -> some View {
    self.sheet(isPresented: isPresented) {
      ShareView(items: items, activities: activities)
    }
  }
}

private struct ShareView: View {
  let items: [Any]
  var activities: [UIActivity]?
  
  var body: some View {
    ActivityRepresentable(items: items, activities: activities)
      .ignoresSafeArea()
      .presentationDetents([.medium, .large])
  }
}


private struct ActivityRepresentable: UIViewControllerRepresentable {
  let items: [Any]
  let activities: [UIActivity]?
  
  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
  func makeUIViewController(context: Context) -> UIActivityViewController {
    UIActivityViewController(
      activityItems: items,
      applicationActivities: activities
    )
  }
}

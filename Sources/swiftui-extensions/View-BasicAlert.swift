//
//  View-BasicAlert.swift
//

import SwiftUI

extension View {
  public func basicAlert<Error>(
    error: Binding<Error?>,
    title: LocalizedStringKey = LocalizedStringKey("Alert")
  ) -> some View
  where Error: Swift.Error, Error: Identifiable, Error: LocalizedError {
    self.alert(item: error) { error in
      Alert(
        title: Text(title),
        message: Text(error.errorDescription ?? "Something went wrong!"),
        dismissButton: .cancel()
      )
    }
  }
}

enum SomeError: Identifiable, LocalizedError {
  case unknown
  
  var id: Self { self }
  var errorDescription: String? {
    "Some error message"
  }
}

struct SomeView: View {
  @State private var error: SomeError?
  
  var body: some View {
    ScrollView {
      Text("First")
      Text("Second")
      Text("Third")
      Button("Show error") {
        error = .unknown
      }
    }
    .basicAlert(error: $error)
  }
}

#Preview {
  SomeView()
}


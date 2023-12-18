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

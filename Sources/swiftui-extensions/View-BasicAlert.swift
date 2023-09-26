//
//  View-BasicAlert.swift
//

import SwiftUI

extension View {
  public func basicAlert<Error>(
    error: Binding<Error?>,
    title: String = "Alert"
  ) -> some View
  where Error: Swift.Error, Error: Identifiable, Error: LocalizedError {
    self.alert(item: error) { error in
      Alert(
        title: Text(title),
        message: Text(error.errorDescription ?? ""),
        dismissButton: .cancel()
      )
    }
  }
}


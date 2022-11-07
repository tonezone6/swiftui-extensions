//
//  SwiftUIView.swift
//  
//
//  Created by Alex S. on 06/11/2022.
//

import SwiftUI

extension View {
    public func alert<E>(error: Binding<E?>, title: String = "Alert") -> some View
    where E: Error, E: Identifiable, E: LocalizedError {
        self.alert(item: error) { error in
            Alert(
                title: Text(title),
                message: Text(error.errorDescription ?? ""),
                dismissButton: .cancel()
            )
        }
    }
}

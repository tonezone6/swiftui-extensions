//
//  SwiftUIView.swift
//  
//
//  Created by Alex S. on 06/11/2022.
//

import SwiftUI

extension View {
    public func sheet<Content: View>(
        isPresented: Binding<Bool>,
        detents: [SheetDetent],
        dragIndicator: Bool = true,
        content: @escaping () -> Content) -> some View {
            
        self.sheet(isPresented: isPresented) {
            if #available(iOS 16.0, *) {
                content()
                    .presentationDetents(Set(detents.map(\.presentationDetent)))
                    .presentationDragIndicator(dragIndicator ? .visible : .hidden)
            } else {
                content()
            }
        }
    }
}

public enum SheetDetent: Hashable {
    case medium
    case large
    case fraction(CGFloat)
    case height(CGFloat)
    
    @available(iOS 16.0, *)
    var presentationDetent: PresentationDetent {
        switch self {
        case .medium:
            return .medium
        case .large:
            return .large
        case .fraction(let value):
            return .fraction(value)
        case .height(let value):
            return .height(value)
        }
    }
}

//
//  LoadingButton.swift
//

import SwiftUI

public struct LoadingButton: View {
  public let title: String
  public let systemImage: String?
  public let action: () async -> Void
  
  @State private var loading = false
  @State private var task: Task<Void, Never>?
  
  public init(
    _ title: String,
    systemImage: String? = nil,
    action: @escaping () async -> Void
  ) {
    self.title = title
    self.systemImage = systemImage
    self.action = action
  }

  public var body: some View {
    Button(title, systemImage: systemImage ?? "") {
      if let task = task, !task.isCancelled {
        stopTask()
      } else {
        startTask()
      }
    }
    .labelStyle(.loading(loading))
  }
  
  private func startTask() {
    task = Task {
      loading = true
      await action()
      loading = false
      task = nil
    }
  }
  
  private func stopTask() {
    task?.cancel()
    task = nil
  }
}

extension LabelStyle where Self == LoadingLabelStyle {
  static func loading(_ loading: Bool) -> Self {
    LoadingLabelStyle(loading: loading)
  }
}

struct LoadingLabelStyle: LabelStyle {
  let loading: Bool
  
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: 8) {
      configuration.title.contentTransition(.identity)
      if loading {
        ProgressView()
      } else {
        configuration.icon.fontWeight(.heavy)
      }
    }
  }
}

private extension ButtonStyle where Self == RoundedRectButtonStyle {
  static var roundedBlue: RoundedRectButtonStyle {
    RoundedRectButtonStyle(
      foregroundColor: .white,
      backgroundColor: .blue,
      cornerRadius: 8
    )
  }
}

#Preview {
  VStack {
    Button("Continue") {}
    LoadingButton("Upload", systemImage: "arrow.up") {
      try? await Task.sleep(for: .seconds(1))
    }
  }
  .buttonStyle(.roundedBlue)
  .padding()
}

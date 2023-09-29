# SwiftUI extensions

A collection of SwiftUI convenient extensions and reusable custom views.

### Loading button

SwiftUI button to handle async work and cancellation.

```swift
LoadingButton("Upload", systemImage: "arrow.up") {
  /// tap to perform async work
  /// tap again to cancel task
  // async work here...
}
```

### Checkmark toggle

```swift
Toggle("Show more options", isOn: $showMore)
  .toggleStyle(.checkCircle)
```

### Stretching header

```swift
StretchingHeader {
  Image(.landscape)
    .resizable()
    .scaledToFill()
  Text("Photo credits: Marcus Lee")
    .font(.caption)
}
```

### Basic alert

Convenient alert view modifier using an identifiable error type.

```swift
enum SomeError: Identifiable, LocalizedError {
  case unknown
  
  var id: Self { self }
  var errorDescription: String? {
    "An error message"
  }
}

struct SomeView: View {
  @State private var error: SomeError?
  
  var body: some View {
    ScrollView {
      //...
    }
    .basicAlert(error: $error)
  }
}
```

### Share sheet

`SwiftUI` sheet based on `UIKit` `UIActivityViewController`.

```swift
struct SomeView: View {
  @State private var showSheet = false
  
  var body: some View {
    ScrollView {
      //...
    }
    .shareSheet(isPresented: $showSheet, items: [product.url])
  }
}
```

### Navigation appearence

```swift
NavigationStack {
  ContentView()
}
.navigationAppearence(
  backgroundColor: .white,
  foregroundColor: .black,
  backSystemImage: "arrow.left"
)
```

# SwiftUI extensions

A collection of SwiftUI convenient extensions.

### Loading button

```swift
LoadingButton("Upload", systemImage: "arrow.up") {
  // async work...
}
```

### Checkmark toggle

```swift
Toggle("Show more options", isOn: $showMore)
  .toggleStyle(.checkCircle)
```

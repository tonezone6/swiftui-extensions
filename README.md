# SwiftUI extensions

A collection of SwiftUI extensions helping with convenience and backward compatibility.

### Backward compatible sheet modifier

```swift
@State private var isPresented = false

var body: some View {
    VStack {
        Text("Hello, sheet!")
        Button("Show") {
            isPresented.toggle()
        }
    }
    .sheet(isPresented: $isPresented, detents: [.medium, .large]) {
        Text("This is the new iOS 16 sheet using detents! Previous iOS versions will display a regular sheet.")
    }
}
```

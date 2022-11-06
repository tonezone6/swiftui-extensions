# SwiftUI extensions

A collection of SwiftUI extensions helping with convenience and backward compatibility.

### Backward compatible sheet modifier

```swift
struct SomeView: View {
    @ObservedObject var model: SomeModel
    @State private var isPresented = false

    var body: some View {
        VStack {
            Text("Hello, sheet!")
            
            Button("Show new sheet", image: .arrowUp, position: .right) {
                isPresented.toggle()
            }
            .buttonStyle(.mint)
        }
        .sheet(isPresented: $isPresented, detents: [.medium, .large]) {
            /// Hello, new sheet using detents! 
            /// Pre - iOS 16 versions will display a regular sheet.
            /// Sheet content here...
        }
        .simpleAlert(error: $model.error)
    }
}
```

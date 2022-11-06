# SwiftUI extensions

A collection of SwiftUI extensions helping with convenience and backward compatibility.

### Backward compatible sheet modifier

```swift
struct SomeView: View {
    @ObservedObject var model: Model
    @State private var isPresented = false

    var body: some View {
        VStack {
            Text("Hello, sheet!")
            Button("Show sheet") {
                isPresented.toggle()
            }
        }
        .sheet(isPresented: $isPresented, detents: [.medium, .large]) {
            Text(""" 
                Hello, new sheet using detents! 
                Pre - iOS 16 versions will display a regular sheet.
            """
            )
        }
        .simpleAlert(error: $model.error)
    }
}
```

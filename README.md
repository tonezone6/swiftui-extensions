# SwiftUI extensions

A collection of SwiftUI extensions helping with convenience and backward compatibility.

### Backward compatible sheet modifier

```swift
struct ContentView: View {
    @ObservedObject var model: Model

    var body: some View {
        VStack {
            Text("Hello, sheet!")
            
            Button("Show sheet", image: .arrowUp, position: .right) {
                model.showSheet()
            }
            .buttonStyle(.mint)
        }
        .sheet(isPresented: $model.isSheetPresented, detents: [.medium, .large]) {
            /// Hello, new sheet using detents! 
            /// pre-iOS 16 versions will display a regular sheet
        }
        .alert(error: $model.error)
    }
}
```

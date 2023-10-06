# SwiftUI extensions

A collection of SwiftUI convenient extensions and reusable custom views.

### Basic alert

Convenient alert view modifier using an identifiable error type and displaying the localized error message.

```swift
struct ListView: View {
  @State private var error: MyError?
  
  var body: some View {
    ScrollView {
      //...
    }
    .basicAlert(error: $error)
  }
}
```

### Loading button

SwiftUI button that handles async work and cancellation.

```swift
/// Tap to perform async work 
/// or tap again to cancel the task.
LoadingButton("Upload", systemImage: "arrow.up") {
  // async work...
}
```

### Flow stack

`FlowStack`is similar to `VStack` and `HStack` layouts, but wrapping the content vertically when there is no space left horizontally. 

```swift
ScrollView {
  FlowStack {
    ForEach(items, id: \.self) { item in
      TagView(item)
    }
  }
  .frame(maxWidth: .infinity, alignment: .leading)
  .padding()
}
```
![Screenshot](simulator-flow-stack.png)

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

### Toggle style: checkmark

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

### Lorem Ipsum text generator

```swift
// ...
guard let string = String.loremIpsum(words: 20) else { return }
/// generating an array of unique strings 
/// that can be then used with SwiftUI.
let items = string.uniqueStrings(splitBy: " ")
// ...
```

### Navigation bar appearence

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

### View size overlay

```swift
VStack(spacing: 0) {
  Rectangle().fill(.mint)
  Rectangle().fill(.brown)
  Rectangle().fill(.red)
  Rectangle().fill(.orange)
  Rectangle().fill(.yellow)
  Rectangle().fill(.cyan).overlaySize()
  Rectangle().fill(.teal)
  Rectangle().fill(.blue)
}
.ignoresSafeArea()
```
![Screenshot](simulator-overlay-size.png)

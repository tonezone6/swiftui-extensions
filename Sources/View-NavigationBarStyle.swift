import SwiftUI

public struct NavigationBarStyle: ViewModifier {
    
    public struct BackButton {
        public let image: UIImage
        public let weight: UIImage.SymbolWeight
        
        public init(_ systemName: BackButtonSystemName, weight: UIImage.SymbolWeight) {
            self.weight = weight
            self.image = UIImage(
                systemName: systemName.rawValue,
                withConfiguration: UIImage.SymbolConfiguration(weight: weight)
            )!
        }
    }
    
    public enum BackButtonSystemName: String {
        case arrowLeft = "arrow.left"
    }
    
    let tintColor: Color?
    
    public init(
        titleColor: Color,
        backgroundColor: Color,
        tintColor: Color?,
        backButton: BackButton?,
        showSeparator: Bool
    ) {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor : UIColor(titleColor)]
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor(titleColor)]
        appearance.backgroundColor = UIColor(backgroundColor)
        
        if let backButton {
            appearance.setBackIndicatorImage(backButton.image, transitionMaskImage: backButton.image)
        }
        
        if !showSeparator {
            appearance.shadowColor = .clear
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        self.tintColor = tintColor
    }
    
    public func body(content: Content) -> some View {
        content.tint(tintColor)
    }
}

extension UINavigationController {
    // Force back button text hidden
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

extension NavigationStack {
    public func barStyle(
        titleColor: Color,
        backgroundColor: Color,
        tintColor: Color = .accentColor,
        backButton: NavigationBarStyle.BackButton,
        showSeparator: Bool = true
    ) -> some View {
        self.modifier(
            NavigationBarStyle(
                titleColor: titleColor,
                backgroundColor: backgroundColor,
                tintColor: tintColor,
                backButton: backButton,
                showSeparator: showSeparator
            )
        )
    }
}

// MARK: - Preview

struct ContentView: View {
    var body: some View {
        List(1...10, id: \.self) { row in
            NavigationLink {
                detailsView(with: row)
            } label: {
                Text(row.formatted())
            }
        }
    }
    
    func detailsView(with row: Int) -> some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
            Text(row.formatted(.number))
                .font(.system(size: 150))
                .fontWeight(.bold)
                .foregroundStyle(.gray.opacity(0.2))
        }
        .navigationTitle(spellout(row))
    }
    
    func spellout(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        let number = NSNumber(value: number)
        return formatter.string(from: number)?.capitalized ?? ""
    }
}

extension Color {
    init(light: Color, dark: Color) {
        let uiColor = UIColor(dynamicProvider: { traits in
            switch traits.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default:
                return UIColor(light)
            }
        })
        self.init(uiColor: uiColor)
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .navigationTitle("One to Ten")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Button") {}
            }
    }
    .barStyle(
        titleColor: .primary,
        backgroundColor: .init(light: .white, dark: .white.opacity(0.01)),
        tintColor: .red,
        backButton: .init(.arrowLeft, weight: .semibold),
        showSeparator: false
    )
}


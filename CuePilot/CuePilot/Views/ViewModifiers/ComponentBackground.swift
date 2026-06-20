
import SwiftUI

private struct ComponentBackground: EnvironmentKey {
    static let defaultValue: AnyShapeStyle = AnyShapeStyle(Color.black)
}

public extension EnvironmentValues {
    var componentBackground: AnyShapeStyle {
        get { self[ComponentBackground.self] }
        set { self[ComponentBackground.self] = newValue }
    }
}

public extension View {
    
    /// A background style view modifier that can be used within view components internally.  It
    /// is up to the component to decide where it makes sense to apply this style within the
    /// context of their view hierarchy.  This modifier is similar to SwiftUI's standard
    /// `background()` modifier (which is not available for custom view components to access)
    /// - Parameter style: The style to apply
    /// - Returns: The receiving view
    func componentBackground<S: ShapeStyle>(_ style: S) -> some View {
        environment(\.componentBackground, AnyShapeStyle(style))
    }
}


import SwiftUI

private struct ComponentForeground: EnvironmentKey {
    static let defaultValue: AnyShapeStyle = AnyShapeStyle(Color.black)
}

public extension EnvironmentValues {
    var componentForeground: AnyShapeStyle {
        get { self[ComponentForeground.self] }
        set { self[ComponentForeground.self] = newValue }
    }
}

public extension View {
    
    /// A foreground style view modifier that can be used within view components internally.  It
    /// is up to the component to decide where it makes sense to apply this style within the
    /// context of their view hierarchy.  This modifier is similar to SwiftUI's standard
    /// `foregroundStyle()` modifier (which is not available for custom view components to access)
    /// - Parameter style: The style to apply
    /// - Returns: The receiving view
    func componentForeground<S: ShapeStyle>(_ style: S) -> some View {
        environment(\.componentForeground, AnyShapeStyle(style))
    }
}

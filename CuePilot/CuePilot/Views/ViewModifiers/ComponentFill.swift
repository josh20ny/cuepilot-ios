
import SwiftUI

private struct ComponentFill: EnvironmentKey {
    static let defaultValue: AnyShapeStyle = AnyShapeStyle(Color.gray)
}

public extension EnvironmentValues {
    var componentFill: AnyShapeStyle {
        get { self[ComponentFill.self] }
        set { self[ComponentFill.self] = newValue }
    }
}

public extension View {
    
    /// A view modifier that can be used within view components internally.
    /// Fills a shape with a color or gradient.  It is up to the component to decide where it
    /// makes sense to apply this style within the context of their view hierarchy.  This modifier
    /// is similar to SwiftUI's standard
    /// `background()` modifier (which is not available for custom view components to access)
    /// - Parameter style: The style to apply
    /// - Returns: The receiving view
    func componentFill<S: ShapeStyle>(_ style: S) -> some View {
        environment(\.componentFill, AnyShapeStyle(style))
    }
}

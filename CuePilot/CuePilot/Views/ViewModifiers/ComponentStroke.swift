
import SwiftUI

private struct ComponentStroke: EnvironmentKey {
    static let defaultValue: AnyShapeStyle = AnyShapeStyle(Color.black)
}

public extension EnvironmentValues {
    var componentStroke: AnyShapeStyle {
        get { self[ComponentStroke.self] }
        set { self[ComponentStroke.self] = newValue }
    }
}

public extension View {
    
    /// A stroke style view modifier that can be used within view components internally.  It
    /// is up to the component to decide where it makes sense to apply this style within the
    /// context of their view hierarchy.  This modifier is similar to SwiftUI's standard
    /// `stroke()` modifier (which is not available for custom view components to access)
    /// - Parameter style: The style to apply
    /// - Returns: The receiving view
    func componentStroke<S: ShapeStyle>(_ style: S) -> some View {
        environment(\.componentStroke, AnyShapeStyle(style))
    }
}

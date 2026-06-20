
import SwiftUI

public struct CustomFrame: Sendable, Encodable {
    let width: CGFloat?
    let height: CGFloat?
    
    static var notDefined: CustomFrame {
        CustomFrame(width: nil, height: nil)
    }
}

private struct ComponentFrame: EnvironmentKey {
    static let defaultValue: CustomFrame = .notDefined
}

public extension EnvironmentValues {
    var componentFrame: CustomFrame {
        get { self[ComponentFrame.self] }
        set { self[ComponentFrame.self] = newValue }
    }
}

public extension View {
    
    /// A frame view modifier that can be used within view components internally.  It
    /// is up to the component to decide where it makes sense to apply this style within the
    /// context of their view hierarchy.  This modifier is similar to SwiftUI's standard
    /// `frame()` modifier (which is not available for custom view components to access)
    /// - Parameter style: The style to apply
    /// - Returns: The receiving view
    func componentFrame(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        environment(\.componentFrame, CustomFrame(width: width, height: height))
    }
}

import SwiftUI
import Combine

final class Router: ObservableObject {
    @Published var popup: PopupRoute?

    @MainActor
    func presentPopup(_ route: PopupRoute) {
        popup = route
    }

    @MainActor
    func dismissPopup() {
        popup = nil
    }
}

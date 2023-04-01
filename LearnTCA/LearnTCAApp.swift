import SwiftUI
import ComposableArchitecture

@main
struct LearnTCAApp: App {
  var body: some Scene {
    WindowGroup {
      ProductListView(
        store: Store(
          initialState: ProductListFeature.State(),
          reducer: ProductListFeature(
            fetchProducts: { Product.sample },
            sendOrder: { _ in "OK" }
          )
        )
      )
    }
  }
}

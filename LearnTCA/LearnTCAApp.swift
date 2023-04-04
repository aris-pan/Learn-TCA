import SwiftUI
import ComposableArchitecture

struct MyError: Error {}

@main
struct LearnTCAApp: App {
  var body: some Scene {
    WindowGroup {
      ProductListView(
        store: Store(
          initialState: ProductListFeature.State(),
          reducer: ProductListFeature(
            fetchProducts: APIClient.live.fetchProducts,
            sendOrder: APIClient.live.sendOrder
          )
        )
      )
    }
  }
}

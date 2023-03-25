import SwiftUI
import ComposableArchitecture

@main
struct LearnTCAApp: App {
  var body: some Scene {
    WindowGroup {
      ProductListView(
        store: Store(
          initialState: ProductListDomain.State(),
          reducer: ProductListDomain.reducer,
          environment: ProductListDomain.Environment(
            fetchProducts: {
              Product.sample
            }
          )
        )
      )
    }
  }
}

import SwiftUI
import ComposableArchitecture

struct CardListView: View {
  let store: StoreOf<CartListFeature>
  var body: some View {
    WithViewStore(store) { viewStore in
      List {
        ForEachStore(
          self.store.scope(
            state: \.cartItems,
            action: CartListFeature.Action
              .cartItems(id:action:)
          )
        ) {
          CartCell(store: $0)
        }
      }
    }
  }
}

struct CardListView_Previews: PreviewProvider {
  static var previews: some View {
    CardListView(
      store: Store(
        initialState: CartListFeature.State(
          cartItems: IdentifiedArrayOf(
            uniqueElements: CartItem.sample
              .map {
                CartItemFeature.State(
                  id: UUID(),
                  cartItem: $0
                )
              }
          )
        ),
        reducer: CartListFeature()
      )
    )
  }
}

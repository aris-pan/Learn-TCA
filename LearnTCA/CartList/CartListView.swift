import SwiftUI
import ComposableArchitecture

struct CartListView: View {
  let store: StoreOf<CartListFeature>
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationStack {
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
        .navigationTitle("Cart")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              viewStore.send(.didPressCloseButton)
            } label: {
              Text("Close")
            }
          }
        }
        .safeAreaInset(edge: .bottom) {
          Button {
            viewStore.send(.didPressPayButton)
          } label: {
            HStack(alignment: .center) {
              Spacer()
              Text("Pay $\(viewStore.totalPrice.formatted())")
                .font(.custom("AmericanTypewriter", size: 30))
                .foregroundColor(.white)
              Spacer()
            }
          }
          .frame(maxWidth: .infinity, minHeight: 60)
          .background(viewStore.isPayButtonDisabled ? .gray : .blue)
          .cornerRadius(10)
          .padding()
          .disabled(viewStore.isPayButtonDisabled)
        }
      }
      .task {
        viewStore.send(.getTotalPrice)
      }
    }
  }
}

struct CartListView_Previews: PreviewProvider {
  static var previews: some View {
    CartListView(
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
        reducer: CartListFeature(sendOrder: { _ in "OK" })
      )
    )
  }
}

import SwiftUI
import ComposableArchitecture

struct CartListView: View {
  let store: StoreOf<CartListFeature>
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationStack {
        ZStack {
          Group {
            if viewStore.cartItems.isEmpty {
              Text("Oops, your cart is empty! \n")
                .font(.custom("AmericanTypewriter", size: 25))
            } else {
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
          .task {
            viewStore.send(.getTotalPrice)
          }
          .alert(
            self.store.scope(state: \.confirmationAlert),
            dismiss: .didCancelConfirmation
          )
          .alert(
            self.store.scope(state: \.errorAlert),
            dismiss: .dismissErrorAlert
          )
          .alert(
            self.store.scope(state: \.successAlert),
            dismiss: .dismissSuccessAlert
          )
        }
        if viewStore.isLoading {
          Color.black.opacity(0.2)
          ProgressView()
            .frame(width: 100, height: 100)
        }
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
        reducer: CartListFeature()
      )
    )
  }
}

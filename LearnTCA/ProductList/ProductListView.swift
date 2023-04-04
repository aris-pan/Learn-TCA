import SwiftUI
import ComposableArchitecture

struct ProductListView: View {
  let store: StoreOf<ProductListFeature>
  
  var body: some View {
    NavigationStack {
      WithViewStore(self.store) { viewStore in
        Group {
          if viewStore.isLoading {
            ProgressView()
              .frame(width: 100, height: 100)
          } else if viewStore.shouldShowError {
            ErrorView(
              message: "Oops we couldn't fetch the products") {
                viewStore.send(.fetchProducts)
              }
          } else {
            List {
              ForEachStore(
                self.store.scope(
                  state: \.productItems,
                  action: ProductListFeature.Action.productItems(id:action:)
                )
              ) {
                ProductCell(store: $0)
              }
            }
          }
        }
        .task {
          viewStore.send(.fetchProducts)
        }
        .navigationTitle("Products")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              viewStore.send(.setCart(isPresented: true))
            } label: {
              Text("Go to Cart")
            }
          }
        }
        .sheet(
          isPresented: viewStore.binding(
            get: \.shouldOpenCart,
            send: { .setCart(isPresented: $0) }
          )
        ) {
          IfLetStore(
            self.store.scope(
              state: \.cartState,
              action: ProductListFeature.Action.cart
            )
          ) {
            CartListView(store: $0)
          }
        }
      }
    }
  }
}

struct ProductListView_Previews: PreviewProvider {
  static var previews: some View {
    ProductListView(
      store: Store(
        initialState: ProductListFeature.State(),
        reducer: ProductListFeature()
      )
    )
  }
}

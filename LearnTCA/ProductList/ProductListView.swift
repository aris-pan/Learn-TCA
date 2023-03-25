import SwiftUI
import ComposableArchitecture

struct ProductListView: View {
  let store: Store<ProductListDomain.State, ProductListDomain.Action>
  var body: some View {
    NavigationStack {
      WithViewStore(self.store) { viewStore in
        List {
          ForEachStore(
            self.store.scope(
              state: \.productList,
              action: ProductListDomain.Action.product(id:action:)
            )
          ) {
            ProductCell(store: $0)
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
          Text("Cart!")
        }
      }
    }
  }
}

struct ProductListView_Previews: PreviewProvider {
  static var previews: some View {
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
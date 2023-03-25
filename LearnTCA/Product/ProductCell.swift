import SwiftUI
import ComposableArchitecture

struct ProductCell: View {
  let store: Store<ProductDomain.State, ProductDomain.Action>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        Image(viewStore.product.imageString)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: 300)
        
        VStack(alignment: .leading) {
          Text(viewStore.product.title)
            .font(.custom("AmericanTypewriter", size: 20))
          HStack {
            Text("$\(viewStore.product.price.description)")
              .font(.custom("AmericanTypewriter", size: 25))
              .fontWeight(.bold)
            Spacer()
            AddToCartButton(
              store: self.store.scope(
                state: \.addToCartState,
                action: ProductDomain.Action.addToCart
              )
            )
          }
        }
      }
      .padding(20)
    }
  }
}

struct ProductCell_Previews: PreviewProvider {
  static var previews: some View {
    ProductCell(
      store: Store(
        initialState: ProductDomain.State(product: Product.sample[0]),
        reducer: ProductDomain.reducer,
        environment: ProductDomain.Environment()
      )
    )
    .border(.black)
  }
}

import SwiftUI
import ComposableArchitecture

struct CartCell: View {
  let store: StoreOf<CartItemFeature>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        HStack {
          AsyncImage(
            url: viewStore.cartItem.product.imageURL
          ) {
            $0
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 100, height: 100)
          } placeholder: {
            ProgressView()
              .frame(width: 100, height: 100)
          }
          VStack(alignment: .leading) {
            Text(viewStore.cartItem.product.title)
              .lineLimit(3)
              .minimumScaleFactor(0.5)
            
            HStack {
              Text("$\(viewStore.cartItem.product.price.description)")
                .font(.custom("AmericanTypewriter", size: 25))
                .fontWeight(.bold)
            }
          }
        }
        Group {
          Text("Quantity: ")
          +
          Text("\(viewStore.cartItem.quantity)")
            .fontWeight(.bold)
        }
        .font(.custom("AmericanTypewriter", size: 25))
      }
    }
  }
}

struct CartCell_Previews: PreviewProvider {
  static var previews: some View {
    CartCell(
      store: Store(
        initialState: CartItemFeature.State(
          id: UUID(),
          cartItem: CartItem.sample[0]
        ),
        reducer: CartItemFeature()
      )
    )
  }
}

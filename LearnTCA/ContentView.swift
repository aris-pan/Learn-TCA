import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
      AddToCartButton(
        store: Store(
          initialState: AddToCartDomain.State(counter: 0),
          reducer: AddToCartDomain.reducer,
          environment: AddToCartDomain.Environment()
        )
      )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}

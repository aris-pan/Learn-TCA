import SwiftUI
import ComposableArchitecture

struct AddToCartButton: View {
  let store: Store<AddToCartFeature.State, AddToCartFeature.Action>

  var body: some View {
    WithViewStore(self.store) { viewStore in
      if viewStore.counter < 1 {
        Button {
          viewStore.send(.didTapPlusButton)
        } label: {
          Text("Add to Cart")
            .padding(10)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .buttonStyle(.plain)

      } else {
        PlusMinusButton(store: self.store)        
      }
    }
  }
}

struct AddToCartButton_Previews: PreviewProvider {
  static var previews: some View {
    AddToCartButton(
      store: Store(
        initialState: AddToCartFeature.State(),
        reducer: AddToCartFeature())
    )
  }
}

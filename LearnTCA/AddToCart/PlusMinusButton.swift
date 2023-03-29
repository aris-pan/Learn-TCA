import SwiftUI
import ComposableArchitecture

struct PlusMinusButton: View {
  let store: StoreOf<AddToCartFeature>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      HStack {
        Button {
          viewStore.send(.didTapPlusButton)
        } label: {
          Text("+")
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
        
        Text("\(viewStore.counter)")
        
        Button {
          viewStore.send(.didTapMinusButton)
        } label: {
          Text("-")
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
      }
    }
  }
}

struct PlusMinusButton_Previews: PreviewProvider {
  static var previews: some View {
    PlusMinusButton(
      store: Store(
        initialState: AddToCartFeature.State(),
        reducer: AddToCartFeature()
      )
    )
  }
}

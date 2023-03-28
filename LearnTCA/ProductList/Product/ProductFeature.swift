import Foundation
import ComposableArchitecture


struct ProductFeature: ReducerProtocol {
  struct State: Equatable, Identifiable {
    let id: UUID
    let product: Product
    var addToCartState = AddToCartFeature.State()
  }
  
  enum Action: Equatable {
    case addToCart(AddToCartFeature.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Scope(state: \.addToCartState, action: /Action.addToCart) {
      AddToCartFeature()
    }
    Reduce { state, action in
      switch action {
      case .addToCart(.didTapPlusButton):
        return .none
      case .addToCart(.didTapMinusButton):
        state.addToCartState.counter = max(0, state.addToCartState.counter)
        return .none
      }
    }
  }
}

import Foundation
import ComposableArchitecture

struct ProductDomain {
  struct State: Equatable, Identifiable {
    let id: UUID
    let product: Product
    var addToCartState = AddToCartFeature.State()
  }
  
  enum Action: Equatable {
    case addToCart(AddToCartFeature.Action)
  }
  
  struct Environment {}
  
  static let reducer = AnyReducer<
    State, Action, Environment
  >.combine(
    AnyReducer {
      AddToCartFeature()
    }
      .pullback(
        state: \.addToCartState,
        action: /ProductDomain.Action.addToCart,
        environment: { $0 }
      ),
    
      .init { state, action, environment in
        switch action {
        case .addToCart(.didTapPlusButton):
          return .none
        case .addToCart(.didTapMinusButton):
          state.addToCartState.counter = max(0, state.addToCartState.counter)
          return .none
        }
      }
  )
}

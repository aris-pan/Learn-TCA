import Foundation
import ComposableArchitecture

struct CartListFeature: ReducerProtocol {
  struct State: Equatable {
    var cartItems: IdentifiedArrayOf<CartItemFeature.State> = []
    var totalPrice: Double = 0.0
    var isPayButtonDisabled = false
  }
  
  enum Action: Equatable {
    case didPressCloseButton
    case cartItems(id: CartItemFeature.State.ID, action: CartItemFeature.Action)
    case getTotalPrice
    case pay
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .didPressCloseButton:
        return .none
      case .cartItems(let id, let action):
        switch action {
        case .deleteCartItem:
          state.cartItems.remove(id: id)
          return EffectTask(value: .getTotalPrice)
        }
      case .getTotalPrice:
        let items = state.cartItems.map { $0.cartItem }
        state.totalPrice = items.reduce(0.0, {
          $0 + ($1.product.price * Double($1.quantity))
        })
      case .pay:
        return .none
      }
      return .none
    }
    .forEach(\.cartItems, action: /Action.cartItems) {
      CartItemFeature()
    }
  }
}

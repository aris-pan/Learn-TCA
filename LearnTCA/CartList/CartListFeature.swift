import Foundation
import ComposableArchitecture

struct CartListFeature: ReducerProtocol {
  struct State: Equatable {
    var cartItems: IdentifiedArrayOf<CartItemFeature.State> = []
  }
  
  enum Action: Equatable {
    case didPressCloseButton
    case cartItems(
      id: CartItemFeature.State.ID,
      action: CartItemFeature.Action
    )
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .didPressCloseButton:
        return .none
      case .cartItems:
        return .none
      }
    }
    .forEach(\.cartItems, action: /Action.cartItems) {
      CartItemFeature()
    }
  }
}

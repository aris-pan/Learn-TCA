import Foundation
import ComposableArchitecture

struct CartListFeature: ReducerProtocol {
  struct State: Equatable {
    var cartList: IdentifiedArrayOf<CartItemFeature.State> = []
  }
  
  enum Action: Equatable {
    case didPressCloseButton
    case cartList(
      id: CartItemFeature.State.ID,
      action: CartItemFeature.Action
    )
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .didPressCloseButton:
        return .none
      case .cartList:
        return .none
      }
    }
    .forEach(\.cartList, action: /Action.cartList) {
      CartItemFeature()
    }
  }
}

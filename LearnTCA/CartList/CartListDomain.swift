import Foundation
import ComposableArchitecture

struct CartListDomain {
  struct State: Equatable {
    var cartList: IdentifiedArrayOf<CartItemDomain.State> = []
  }
  
  enum Action: Equatable {
    case didPressCloseButton
    case cartItem(id: CartItemDomain.State.ID, action: CartItemDomain.Action)
  }
  
  struct Environment {}
  
  static let reducer = AnyReducer<
  State, Action, Environment
  >.combine(
    CartItemDomain.reducer.forEach(
      state: \.cartList,
      action: /Action.cartItem(id:action:),
      environment: {_ in CartItemDomain.Environment()}
    ),
    .init { state, action, environment in
      switch action {
      case .didPressCloseButton:
        return .none
      case .cartItem:
          return .none
      }
    }
  )
}

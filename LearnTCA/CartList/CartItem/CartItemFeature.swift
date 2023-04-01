import Foundation
import ComposableArchitecture

struct CartItemFeature: ReducerProtocol {
  struct State: Equatable, Identifiable {
    let id: UUID
    var cartItem: CartItem
  }
  
  enum Action: Equatable {
    case deleteCartItem
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .deleteCartItem:
        return .none
      }
    }
  }
}

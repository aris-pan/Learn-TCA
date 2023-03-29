import Foundation
import ComposableArchitecture

struct CartItemFeature: ReducerProtocol {
  struct State: Equatable, Identifiable {
    let id: UUID
    let cartItem: CartItem
  }
  
  enum Action: Equatable {
    case dummyAction
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .dummyAction:
        return .none
      }
    }
  }
}

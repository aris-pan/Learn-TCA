import ComposableArchitecture
import Foundation

struct CartItemDomain {
  struct State: Equatable, Identifiable {
    let id: UUID
    let cartItem: CartItem
  }
  
  enum Action: Equatable {
    
  }
  
  struct Environment {
    
  }
  
  static let reducer = AnyReducer<
  State, Action, Environment
  > { state, action, environment in
    return .none
  }
}

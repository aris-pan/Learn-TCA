import Foundation
import ComposableArchitecture


struct AddToCartFeature: ReducerProtocol {
  struct State: Equatable {
    var counter = 0
  }
  
  enum Action: Equatable {
    case didTapPlusButton
    case didTapMinusButton
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .didTapPlusButton:
      state.counter += 1
      return .none
    case .didTapMinusButton:
      state.counter -= 1
      return .none
    }
  }
}

struct AddToCartDomain {
  struct State: Equatable {
    var counter = 0
  }

  enum Action: Equatable {
    case didTapPlusButton
    case didTapMinusButton
  }

  struct Environment {
    //
  }

  static let reducer = AnyReducer<
    State, Action, Environment
  > { state, action, environment in

    switch action {
    case .didTapPlusButton:
      state.counter += 1
      return .none
    case .didTapMinusButton:
      state.counter -= 1
      return .none
    }
  }
}

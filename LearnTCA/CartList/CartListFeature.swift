import Foundation
import ComposableArchitecture

struct CartListFeature: ReducerProtocol {
  struct State: Equatable {
    var cartItems: IdentifiedArrayOf<CartItemFeature.State> = []
    var totalPrice: Double = 0.0
    var isPayButtonDisabled = false
    var confirmationAlert: AlertState<Action>?
  }
  
  enum Action: Equatable {
    case didPressCloseButton
    case cartItems(id: CartItemFeature.State.ID, action: CartItemFeature.Action)
    case getTotalPrice
    case didPressPayButton
    case didReceivePurchaseResponse(TaskResult<String>)
    case didConfirmPurchase
    case didCancelConfirmation
  }
  
  var sendOrder: (([CartItem]) async throws -> String)
  
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
        state.isPayButtonDisabled = state.totalPrice == 0
        return .none
      case .didPressPayButton:
        state.confirmationAlert = AlertState(
          title: TextState("Confirm your purchase"),
          message: TextState("Do you want to proceed with your purchase of $\(state.totalPrice)?"),
          buttons: [
            .default(
              TextState("Pay $\(state.totalPrice)"),
              action: .send(.didConfirmPurchase)
            ),
            .cancel(
              TextState("Cancel"),
              action: .send(.didCancelConfirmation)
            )
          ]
        )
        return .none
        
      case .didCancelConfirmation:
        state.confirmationAlert = nil
        return .none
      case .didReceivePurchaseResponse(.success(let message)):
        print(message)
        return .none
      case .didReceivePurchaseResponse(.failure(let error)):
        print(error)
        return .none
      case .didConfirmPurchase:
        let items = state.cartItems.map { $0.cartItem }
        return .task {
          await .didReceivePurchaseResponse(
            TaskResult {
              try await sendOrder(items)
            }
          )
        }
      }
    }
    .forEach(\.cartItems, action: /Action.cartItems) {
      CartItemFeature()
    }
  }
}

import Foundation
import ComposableArchitecture

struct CartListFeature: ReducerProtocol {
  struct State: Equatable {
    var dataLoadingStatus = DataLoadingStatus.notStarted

    var cartItems: IdentifiedArrayOf<CartItemFeature.State> = []
    var totalPrice: Double = 0.0
    var isPayButtonDisabled = false
    var confirmationAlert: AlertState<Action>?
    var successAlert: AlertState<Action>?
    var errorAlert: AlertState<Action>?
        
    var isLoading: Bool {
      dataLoadingStatus == .loading
    }
    
    var shouldShowError: Bool {
      dataLoadingStatus == .error
    }
  }
  
  enum Action: Equatable {
    case didPressCloseButton
    case cartItems(id: CartItemFeature.State.ID, action: CartItemFeature.Action)
    case getTotalPrice
    case didPressPayButton
    case didReceivePurchaseResponse(TaskResult<String>)
    case didConfirmPurchase
    case didCancelConfirmation
    case dismissErrorAlert
    case dismissSuccessAlert
  }
  
  var sendOrder: (([CartItem]) async throws -> String)
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .dismissErrorAlert:
        state.errorAlert = nil
        return.none
      case .dismissSuccessAlert:
        state.successAlert = nil
        return.none
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
      case .didReceivePurchaseResponse(.success):
        state.dataLoadingStatus = .success

        state.successAlert = AlertState(
          title: TextState("Order completed. Thank you!"),
          buttons: [
            .default(
              TextState("Done"),
              action: .send(.dismissSuccessAlert)
            )
          ]
        )
        return .none
      case .didReceivePurchaseResponse(.failure):
        state.dataLoadingStatus = .error
        
        state.errorAlert = AlertState(
          title: TextState("Oops, there was a problem with your order. Please try again."),
          buttons: [
            .default(
              TextState("Done"),
              action: .send(.dismissErrorAlert)
            )
          ]
        )
        return .none
      case .didConfirmPurchase:
        if state.dataLoadingStatus == .loading {
          return .none
        }
        
        state.dataLoadingStatus = .loading
        
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
    }._printChanges()
  }
}

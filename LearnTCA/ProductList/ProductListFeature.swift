import Foundation
import ComposableArchitecture

struct ProductListFeature: ReducerProtocol {
  @Dependency(\.uuid) var uuid
  @Dependency(\.apiClient) var apiClient
  
  struct State: Equatable {
    fileprivate var dataLoadingStatus = DataLoadingStatus.notStarted
    var productItems: IdentifiedArrayOf<ProductFeature.State> = []
    var cartState: CartListFeature.State?
    var shouldOpenCart = false
    
    var shouldShowError: Bool {
      dataLoadingStatus == .error
    }
    
    var isLoading: Bool {
      dataLoadingStatus == .loading
    }
  }
  
  enum Action: Equatable {
    case fetchProducts
    case fetchProductResponse(TaskResult<[Product]>)
    case productItems(id: ProductFeature.State.ID, action: ProductFeature.Action)
    case setCart(isPresented: Bool)
    case cart(CartListFeature.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .fetchProducts:
        if state.dataLoadingStatus == .success || state.dataLoadingStatus == .loading {
          return .none
        }
        
        state.dataLoadingStatus = .loading
        
        return .task {
          await .fetchProductResponse(
            TaskResult {
              try await apiClient.fetchProducts()
            }
          )
        }
      case .fetchProductResponse(.success(let products)):
        
        state.dataLoadingStatus = .success
        
        state.productItems = IdentifiedArray(
          uniqueElements: products
            .map {
              ProductFeature.State(
                id: uuid(),
                product: $0)
            }
        )
        return .none
      case .fetchProductResponse(.failure(let error)):
        
        state.dataLoadingStatus = .error
        
        print(error)
        print("Unable to fetch products")
        return .none
      case .productItems:
        return .none
      case .setCart(let isPresented):
        state.shouldOpenCart = isPresented
        state.cartState = isPresented
        ? CartListFeature.State(
          cartItems: IdentifiedArray(
            uniqueElements: state.productItems.compactMap { state in
              state.count > 0
              ? CartItemFeature.State(
                id: uuid(),
                cartItem: CartItem(
                  product: state.product,
                  quantity: state.count
                )
              )
              : nil
            }
          )
        )
        : nil
        return .none
      case .cart(let action):
        switch action {
        case .didPressCloseButton:
          state.shouldOpenCart = false
          return .none
        case .dismissSuccessAlert:
          resetProductsInCart(state: &state)
          state.shouldOpenCart = false
          return .none
        default:
          return .none
        }
      }
    }
    .ifLet(\.cartState, action: /Action.cart) {
      CartListFeature()
    }
    .forEach(\.productItems, action: /Action.productItems) {
      ProductFeature()
    }
  }
  
  private func resetProductsInCart(
    state: inout State
  ) {
    for id in state.productItems.map(\.id) {
      state.productItems[id: id]?.count = 0
    }
  }
}

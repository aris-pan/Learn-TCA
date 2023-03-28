import Foundation
import ComposableArchitecture


struct ProductListFeature: ReducerProtocol {
  struct State: Equatable {
    var productList: IdentifiedArrayOf<ProductFeature.State> = []
    var shouldOpenCart = false
  }
  
  enum Action: Equatable {
    case fetchProducts
    case fetchProductResponse(TaskResult<[Product]>)
    case product(id: ProductFeature.State.ID, action: ProductFeature.Action)
    case setCart(isPresented: Bool)
  }
  
  var fetchProducts: () async throws -> [Product]
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .fetchProducts:
        return .task {
          await .fetchProductResponse(
            TaskResult {
              try await fetchProducts()
            }
          )
        }
        
      case .fetchProductResponse(.success(let products)):
        state.productList = IdentifiedArray(
          uniqueElements: products
            .map {
              ProductFeature.State(
                id: UUID(),
                product: $0)
            }
        )
        return .none
        
      case .fetchProductResponse(.failure(let error)):
        print(error)
        print("Unable to fetch products")
        return .none
      case .product:
        return .none
      case .setCart(let isPresented):
        state.shouldOpenCart = isPresented
        return .none
      }    }
    .forEach(\.productList, action: /Action.product) {
      ProductFeature()
    }
  }
}

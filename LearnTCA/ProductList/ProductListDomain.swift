import Foundation
import ComposableArchitecture

struct ProductListDomain {
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
  
  struct Environment {
    var fetchProducts: () async throws -> [Product]
  }
  
  static let reducer = AnyReducer<
    State, Action, Environment
  >.combine(
    AnyReducer {
      ProductFeature()
    }
    .forEach(
      state: \.productList,
      action: /Action.product(id:action:),
      environment: { $0 }
    ),
    .init { state, action, environment in
      switch action {
      case .fetchProducts:
        return .task {
          await .fetchProductResponse(
            TaskResult {
              try await environment.fetchProducts()
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
      }
    }
  ).debug()
}

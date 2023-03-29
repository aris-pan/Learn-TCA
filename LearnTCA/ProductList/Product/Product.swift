import Foundation

struct Product: Equatable, Identifiable {
  let id: Int
  let title: String
  let price: Double
  let description: String
  let category: String
  let imageURL: URL?
  
  
  static var sample: [Product] {
    [
      .init(
        id: 1,
        title: "Mens Slim Fit T-Shirts",
        price: 22.3,
        description: "Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder ",
        category: "men's clothing",
        imageURL: URL(string: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg")
      ),
      .init(
        id: 3,
        title: "Laptop Backpack",
        price: 105.99,
        description: "Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder ",
        category: "men's clothing",
        imageURL: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
      ),
      .init(
        id: 4,
        title: "Mens Cotton Jacket",
        price: 44.99,
        description: "Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder ",
        category: "men's clothing",
        imageURL: URL(string: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg")
      )
    ]
  }
}

import Foundation

struct Product: Equatable, Identifiable {
  let id: Int
  let title: String
  let price: Double
  let description: String
  let category: String
  let imageString: String
  
  
  static var sample: [Product] {
    [
      .init(
        id: 1,
        title: "Mens Slim Fit T-Shirts",
        price: 22.3,
        description: "Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder ",
        category: "men's clothing",
        imageString: "tshirt"
      ),
      .init(
        id: 2,
        title: "Men's Sneakers",
        price: 34.99,
        description: "Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder ",
        category: "men's clothing",
        imageString: "shoes"
      ),
      .init(
        id: 3,
        title: "Laptop Backpack",
        price: 105.99,
        description: "Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder ",
        category: "men's clothing",
        imageString: "bag"
      ),
      .init(
        id: 4,
        title: "Mens Cotton Jacket",
        price: 44.99,
        description: "Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder Placeholder placeholder ",
        category: "men's clothing",
        imageString: "jacket"
      )
    ]
  }
}

import Foundation

struct Product: Equatable, Identifiable {
  let id: Int
  let title: String
  let price: Double
  let description: String
  let category: String
  let imageURL: URL?
  
}

extension Product: Decodable {
  enum ProductKeys: CodingKey {
    case id
    case title
    case price
    case description
    case category
    case image
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: ProductKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
    self.price = try container.decode(Double.self, forKey: .price)
    self.description = try container.decode(String.self, forKey: .description)
    self.category = try container.decode(String.self, forKey: .category)
    let image = try container.decode(String.self, forKey: .image)
    self.imageURL = URL(string: image)
  }
}

extension Product {
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

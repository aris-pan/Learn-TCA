import Foundation

struct CartItem: Equatable {
  let product: Product
  let quantity: Int

  static var sample: [CartItem] {
    [
      .init(
        product: Product.sample[0],
        quantity: 3
      ),
      .init(
        product: Product.sample[1],
        quantity: 1
      ),
      .init(
        product: Product.sample[2],
        quantity: 1
      )
    ]
  }
}

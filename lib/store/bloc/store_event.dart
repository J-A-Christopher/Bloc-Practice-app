abstract class StoreEvent {}

class StoreProductsRequested extends StoreEvent {}

class StoreProductsAddedToCart extends StoreEvent {
  final int cartId;

  StoreProductsAddedToCart(this.cartId);
}

class StoreProductsRemovedFromCart extends StoreEvent {
  final int cartId;

  StoreProductsRemovedFromCart(this.cartId);
}

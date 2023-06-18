import '../store.dart';

enum StoreRequest { unknown, requestInProgress, requestSuccess, requestFailure }

class StoreState {
  final List<Product> products;
  final StoreRequest productsStatus;
  final Set<int> cartIds;
  StoreState(
      {this.cartIds = const {},
      this.products = const [],
      this.productsStatus = StoreRequest.unknown});

  StoreState copyWith(
          {List<Product>? products,
          StoreRequest? productsStatus,
          Set<int>? cartIds}) =>
      StoreState(
          products: products ?? this.products,
          productsStatus: productsStatus ?? this.productsStatus,
          cartIds: cartIds ?? this.cartIds);
}

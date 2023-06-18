import 'package:bloc2_app/store/repository/store_repository.dart';

import '../store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState()) {
    on<StoreProductsRequested>(_handleProductsRequested);
    on<StoreProductsAddedToCart>(_handleStoreProductAddedToCart);
    on<StoreProductsRemovedFromCart>(_handleStoreProductsRemovedFromCart);
  }

  final StoreRepository api = StoreRepository();
  Future<void> _handleProductsRequested(
      StoreProductsRequested event, Emitter<StoreState> emit) async {
    try {
      emit(state.copyWith(productsStatus: StoreRequest.requestInProgress));
      final response = await api.getProducts();
      emit(state.copyWith(
          productsStatus: StoreRequest.requestSuccess, products: response));
    } catch (e) {
      emit(state.copyWith(productsStatus: StoreRequest.requestFailure));
    }
  }

  Future<void> _handleStoreProductAddedToCart(
      StoreProductsAddedToCart event, Emitter<StoreState> emit) async {
    emit(state.copyWith(cartIds: {...state.cartIds, event.cartId}));
  }

  Future<void> _handleStoreProductsRemovedFromCart(
      StoreProductsRemovedFromCart event, Emitter<StoreState> emit) async {
    emit(state.copyWith(cartIds: {...state.cartIds}..remove(event.cartId)));
  }
}

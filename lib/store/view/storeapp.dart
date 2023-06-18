import 'package:bloc2_app/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: BlocProvider<StoreBloc>(
        create: (context) => StoreBloc(),
        child: const StoreAppView(title: 'My Store'),
      ),
    );
  }
}

class StoreAppView extends StatefulWidget {
  final String title;
  const StoreAppView({super.key, required this.title});

  @override
  State<StoreAppView> createState() => _StoreAppViewState();
}

class _StoreAppViewState extends State<StoreAppView> {
  void _addtoCart(int cartId) {
    context.read<StoreBloc>().add(StoreProductsAddedToCart(cartId));
  }

  void _removeFromCart(int cartId) {
    context.read<StoreBloc>().add(StoreProductsRemovedFromCart(cartId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<StoreBloc, StoreState>(builder: ((context, state) {
          if (state.productsStatus == StoreRequest.requestInProgress) {
            return const CircularProgressIndicator();
          }
          if (state.productsStatus == StoreRequest.requestFailure) {
            return Column(
              children: [
                const Text('Problem Loading products'),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    onPressed: () {
                      context.read<StoreBloc>().add(StoreProductsRequested());
                    },
                    child: const Text('Try Again'))
              ],
            );
          }
          if (state.productsStatus == StoreRequest.unknown) {
            return Column(
              children: [
                const Icon(
                  Icons.shop_outlined,
                  size: 60,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('No products to view'),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    onPressed: () {
                      context.read<StoreBloc>().add(StoreProductsRequested());
                    },
                    child: const Text('Load Product'))
              ],
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              final product = state.products[index];
              final inCart = state.cartIds.contains(product.id);
              return Card(
                key: ValueKey(product.id),
                child: Column(
                  children: [
                    Flexible(child: Image.network(product.image)),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                        onPressed: inCart
                            ? () => _removeFromCart(product.id)
                            : () => _addtoCart(product.id),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: inCart
                                ? const []
                                : [
                                    const Icon(Icons.add_shopping_cart),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('Add to cart')
                                  ],
                          ),
                        ))
                  ],
                ),
              );
            },
            itemCount: state.products.length,
          );
        })),
      ),
    );
  }
}

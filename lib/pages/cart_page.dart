import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          centerTitle: true,
        ),
        body: cart.isNotEmpty
            ? ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final cartItem = cart[index];
                  return ListTile(
                    title: Text(
                      cartItem['title'].toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      "Size : ${cartItem['size'].toString()}",
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          // barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Delete Product",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              content: Text(
                                  "Are you sure you want to remove ${cartItem['title']} of size ${cartItem['size']} from the cart?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    context
                                        .read<CartProvider>()
                                        .removeProduct(cartItem);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Product deleted successfully!"),
                                      duration: Duration(seconds: 1),
                                      showCloseIcon: true,
                                    ));
                                  },
                                  child: const Text(
                                    "Yes, sure",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "No, Cancel",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 36,
                      backgroundImage:
                          AssetImage(cartItem['imageUrl'] as String),
                      // child: Image.asset(cartItem['imageUrl'] as String),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                "Empty Cart",
                // style: Theme.of(context).textTheme.titleLarge,
              )));
  }
}

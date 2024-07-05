import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnly_assessment/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart 🛒'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cartItems.isEmpty) {
            return const Center(
              child: Text('No items in cart'),
            );
          }
          return ListView.builder(
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) {
              final product = cartProvider.cartItems[index];
              return ListTile(
                leading: Image.network(product.image ?? 'https://storage.googleapis.com/cms-storage-bucket/64d67700f8293a9dc827.svg'),
                title: Text(product.title ?? 'No title'),
                subtitle: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.nairaSign,
                      size: 12,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      '${product.price}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    cartProvider.removeProductFromCart(product);
                    Fluttertoast.showToast(
                      msg: "Product removed to cart",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.pinkAccent,
                      textColor: Colors.black,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

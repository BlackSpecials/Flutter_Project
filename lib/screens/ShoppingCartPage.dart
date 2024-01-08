import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  final List<String> cartItems;

  const ShoppingCartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Selected Items"),
            for (var item in cartItems)
              ListTile(
                title: Text(item),
              ),
            ElevatedButton(
              onPressed: () {
              },
              child: Text("Proceed to Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}

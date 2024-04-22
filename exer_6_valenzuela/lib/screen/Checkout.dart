import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Item Details"),
            getItems(context),
            if (products.isNotEmpty)
              Flexible(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                    computeCost(),
                    ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCart>().removeAll();
                          Navigator.pushNamed(context, "/products");
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Payment Successful!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                        },
                        child: const Text("Pay Now!")),
                  ]))),
          ],
        ),
      ),
    );
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total: ${cart.cartTotal}");
    });
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Text('No Items in checkout!')
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(products[index].name),
                      trailing: Text("${products[index].price}"));
                },
              )),
            ],
          ));
  }
}

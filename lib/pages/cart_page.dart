import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_page_item.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/order.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    final cartItems = cartProvider.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      bottomSheet: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  ordersProvider.addOrder(cartProvider);
                  cartProvider.clearCart();
                },
                child: Text(
                  'COMPRAR',
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20),
              ),
              SizedBox(width: 10),
              Chip(
                label: Consumer<CartProvider>(
                  builder: (context, cartProvider, child) => Text(
                    'R\$ ${cartProvider.totalPrice.toStringAsFixed(2)}',
                  ),
                ),
                labelStyle: Theme.of(context).primaryTextTheme.subtitle1,
                backgroundColor: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) => ListView.builder(
          itemCount: cartProvider.itemCount,
          itemBuilder: (context, index) {
            return CartPageItem(cartItems[index]);
          },
        ),
      ),
    );
  }
}

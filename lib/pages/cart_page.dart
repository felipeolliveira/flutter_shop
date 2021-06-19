import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_page_item.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/routes/app_routes.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    final cartItems = cartProvider.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        actions: [
          IconButton(
            icon: Icon(Icons.payment_rounded),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDER);
            },
          ),
        ],
      ),
      bottomSheet: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrderButton(
                  cartProvider: cartProvider, ordersProvider: ordersProvider),
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
      body: ListView.builder(
        itemCount: cartProvider.itemCount,
        itemBuilder: (context, index) {
          return CartPageItem(cartItems[index]);
        },
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartProvider,
    @required this.ordersProvider,
  }) : super(key: key);

  final CartProvider cartProvider;
  final OrdersProvider ordersProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Theme.of(context).accentColor,
      ),
      onPressed: widget.cartProvider.totalAmount == 0
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              await widget.ordersProvider.addOrder(widget.cartProvider);

              setState(() {
                _isLoading = false;
              });

              widget.cartProvider.clearCart();
            },
      child: _isLoading
          ? CircularProgressIndicator.adaptive()
          : Text(
              widget.cartProvider.totalAmount == 0
                  ? 'Carrinho vazio'
                  : 'Comprar',
            ),
    );
  }
}

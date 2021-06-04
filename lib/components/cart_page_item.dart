import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartPageItem extends StatelessWidget {
  final CartItem cartItem;

  CartPageItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItemInCart(cartItem.productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cartItem.imageUrl),
              child: null,
            ),
            title: Text(cartItem.title),
            subtitle: Row(
              children: [
                Text('R\$ ${cartItem.price.toStringAsFixed(2)}'),
                SizedBox(width: 5),
                Text(
                  'x',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${cartItem.quantity} uni.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Chip(
              label: Text(
                'R\$ ${cartItem.price * cartItem.quantity}',
                style: Theme.of(context).primaryTextTheme.subtitle1,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

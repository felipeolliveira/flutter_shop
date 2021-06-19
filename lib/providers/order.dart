import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/services/api.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.date,
  });
}

class OrdersProvider with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsAmout {
    return _items.length;
  }

  Future<void> addOrder(CartProvider cart) async {
    final date = DateTime.now();

    final response = await Api('orders.json').post({
      'amount': cart.totalPrice,
      'date': date.toIso8601String(),
      'products': cart.items.values
          .map((cartItem) => {
                'id': cartItem.id,
                'productId': cartItem.productId,
                'title': cartItem.title,
                'quantity': cartItem.quantity,
                'price': cartItem.price,
                'imageUrl': cartItem.imageUrl,
              })
          .toList()
    });

    _items.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        amount: cart.totalPrice,
        date: date,
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';

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

  void addOrder(CartProvider cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        amount: cart.totalPrice,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}

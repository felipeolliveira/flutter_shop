import 'dart:convert';

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
  OrdersProvider([this._token, this._userId, this._items = const []]);

  List<Order> _items;
  final String _token;
  final String _userId;

  List<Order> get items {
    return [..._items];
  }

  int get itemsAmout {
    return _items.length;
  }

  Future<void> addOrder(CartProvider cart) async {
    final date = DateTime.now();

    final response = await Api('/orders/$_userId.json?auth=$_token').post({
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

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];

    final response = await Api('/orders/$_userId.json?auth=$_token').get();
    Map<String, dynamic> data = json.decode(response.body);

    print(data);

    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(Order(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              imageUrl: item['imageUrl'],
              price: item['price'],
              quantity: item['quantity'],
              title: item['title'],
              productId: item['productId'],
            );
          }).toList(),
          date: DateTime.parse(orderData['date']),
        ));
      });
      notifyListeners();
    }

    _items = loadedItems.reversed.toList();

    return Future.value();
  }
}

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    return _items.entries.fold(0, (prev, curr) => prev + curr.value.quantity);
  }

  double get totalPrice {
    return _items.entries.fold(
      0.0,
      (prev, curr) => prev + (curr.value.price * curr.value.quantity),
    );
  }

  void addItemInCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (item) {
          return CartItem(
              id: item.id,
              productId: item.productId,
              title: item.title,
              quantity: item.quantity + 1,
              price: item.price,
              imageUrl: item.imageUrl);
        },
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          title: product.title,
          quantity: 1,
          price: product.price,
          imageUrl: product.imageUrl,
        ),
      );
    }

    notifyListeners();
  }

  void removeItemInCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  void addProduct(Product newProduct) {
    _items.add(
      Product(
        id: Random().nextDouble().toString(),
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        price: newProduct.price,
        title: newProduct.title,
      ),
    );
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final productIndex = _items.indexWhere((prod) => prod.id == product.id);

    if (productIndex >= 0) {
      _items[productIndex] = product;
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    final productIndex = _items.indexWhere((prod) => prod.id == id);

    if (productIndex >= 0) {
      _items.removeWhere((product) => product.id == id);
      notifyListeners();
    }
  }
}

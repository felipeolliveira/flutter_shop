import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop/errors/api_errors.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/services/api.dart';

class ProductsProvider with ChangeNotifier {
  ProductsProvider(this._token, this._items);

  final List<Product> _items;
  final String _token;

  List<Product> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await Api('/products.json?auth=$_token').get();
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();

    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });
      notifyListeners();
    }

    return Future.value();
  }

  Future<void> addProduct(Product newProduct) async {
    final response = await Api('/products.json?auth=$_token').post(
      {
        'description': newProduct.description,
        'imageUrl': newProduct.imageUrl,
        'price': newProduct.price,
        'title': newProduct.title,
        'isFavorite': newProduct.isFavorite,
      },
    );

    _items.add(
      Product(
        id: json.decode(response.body)['name'],
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        price: newProduct.price,
        title: newProduct.title,
      ),
    );

    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final productIndex = _items.indexWhere((prod) => prod.id == product.id);

    if (productIndex >= 0) {
      await Api('/products/${product.id}.json?auth=$_token').patch({
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'title': product.title,
      });

      _items[productIndex] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(String id) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);

    if (productIndex >= 0) {
      final product = _items[productIndex];
      _items.remove(product);
      notifyListeners();

      final response =
          await Api('/products/${product.id}.json?auth=$_token').delete();

      if (response.statusCode >= 400) {
        _items.insert(productIndex, product);
        notifyListeners();
        throw ApiErrors('Ocorreu um erro na exclusão do produto.');
      }
    }
  }
}

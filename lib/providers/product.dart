import 'package:flutter/foundation.dart';
import 'package:shop/services/api.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
    this.isFavorite = false,
  });

  void _toogleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toogleFavorite(String token, String userId) async {
    _toogleFavorite();

    try {
      final response = await Api('/userFavorites/$userId/$id.json?auth=$token')
          .put(isFavorite);

      if (response.statusCode >= 400) {
        _toogleFavorite();
      }
    } catch (error) {
      _toogleFavorite();
    }
  }
}

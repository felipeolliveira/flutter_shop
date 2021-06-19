import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 15),
          Text(product.title),
          Text('R\$ ${product.price.toStringAsFixed(2)}'),
          Text(product.description),
        ],
      )),
    );
  }
}

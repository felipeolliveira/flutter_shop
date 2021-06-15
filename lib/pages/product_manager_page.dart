import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_manager_item.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/routes/app_routes.dart';

class ProductManagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    final productItems = products.items;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_MANAGER_FORM);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemCount,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ProductManagerItem(productItems[index]),
                ),
                Divider(
                  thickness: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

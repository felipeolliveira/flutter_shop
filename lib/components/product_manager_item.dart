import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/routes/app_routes.dart';

class ProductManagerItem extends StatelessWidget {
  final Product product;

  ProductManagerItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_MANAGER_FORM,
                arguments: 'Alteração do item ${product.title}',
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline_rounded),
              color: Theme.of(context).errorColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

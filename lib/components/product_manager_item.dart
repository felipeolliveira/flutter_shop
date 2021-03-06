import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/errors/api_errors.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/routes/app_routes.dart';

class ProductManagerItem extends StatelessWidget {
  final Product product;

  ProductManagerItem(this.product);

  _onRemoveProductItem(
      BuildContext context, ScaffoldMessengerState scaffoldMessenger) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Deseja excluir este item?"),
        content: Text(
            "Uma vez excluído, não será possível recuperar o item, sendo necessário um novo cadastro."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Não'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Sim')),
        ],
      ),
    ).then((value) async {
      if (value) {
        try {
          await Provider.of<ProductsProvider>(
            context,
            listen: false,
          ).removeProduct(product.id);
        } on ApiErrors catch (error) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(
                error.toString(),
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldMessenger = ScaffoldMessenger.of(context);

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
                arguments: product,
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline_rounded),
              color: Theme.of(context).errorColor,
              onPressed: () =>
                  _onRemoveProductItem(context, _scaffoldMessenger),
            ),
          ],
        ),
      ),
    );
  }
}

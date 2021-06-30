import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/routes/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: product.id,
                child: FadeInImage(
                  placeholder: AssetImage(
                    'assets/images/product-placeholder.png',
                  ),
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor:
                      Theme.of(context).accentColor.withOpacity(0.1),
                  splashColor: Theme.of(context).accentColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.PRODUCT_DETAILS,
                        arguments: product);
                  },
                ),
              ),
            ),
          ],
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, _child) {
              return IconButton(
                icon: Icon(
                  product.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  product.toogleFavorite(auth.token, auth.userId);
                },
              );
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItemInCart(product);

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.title} adicionado ao carrinho'),
                  duration: Duration(seconds: 1),
                  action: SnackBarAction(
                    label: 'Desfazer',
                    onPressed: () {
                      cart.removeSingleItemInCart(product);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

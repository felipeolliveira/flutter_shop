import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/routes/app_routes.dart';

enum FilteredOptions { Favorite, All }

class ProductsOverviewPage extends StatefulWidget {
  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          Consumer<CartProvider>(
            child: IconButton(
              icon: Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
            ),
            builder: (_, cart, child) => Badge(
              itemCount: cart.totalAmount.toString(),
              child: child,
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert_rounded),
            onSelected: (FilteredOptions value) {
              switch (value) {
                case FilteredOptions.Favorite:
                  setState(() {
                    showFavoriteOnly = true;
                  });
                  break;
                default:
                  setState(() {
                    showFavoriteOnly = false;
                  });
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Somente favoritos'),
                value: FilteredOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilteredOptions.All,
              ),
            ],
          )
        ],
      ),
      body: Container(
        child: ProductGrid(showFavoriteOnly),
      ),
    );
  }
}

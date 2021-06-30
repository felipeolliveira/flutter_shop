import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/routes/app_routes.dart';

enum FilteredOptions { Favorite, All }

class ProductsOverviewPage extends StatefulWidget {
  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Provider.of<ProductsProvider>(context, listen: false)
        .loadProducts()
        .then((value) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Container(
                child: ProductGrid(showFavoriteOnly),
              ),
      ),
    );
  }
}

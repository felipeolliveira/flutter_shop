import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/index_page.dart';
import 'package:shop/pages/order_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_manager_page.dart';
import 'package:shop/pages/product_manager_form_page.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _providers = [
      ChangeNotifierProvider(
        create: (_) => new AuthProvider(),
      ),
      ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
        create: (_) => new ProductsProvider(null, []),
        update: (_, auth, prevProducts) => ProductsProvider(
          auth.token,
          prevProducts.items,
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => new CartProvider(),
      ),
      ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
        create: (_) => new OrdersProvider(null, []),
        update: (_, auth, prevOrders) => OrdersProvider(
          auth.token,
          prevOrders.items,
        ),
      ),
    ];

    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.red,
          appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            backgroundColor: Colors.deepPurple,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.deepPurple,
              systemNavigationBarColor: Colors.deepPurple,
            ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        initialRoute: AppRoutes.INDEX,
        routes: {
          AppRoutes.INDEX: (context) => IndexPage(),
          AppRoutes.PRODUCT_DETAILS: (context) => ProductDetailPage(),
          AppRoutes.CART: (context) => CartPage(),
          AppRoutes.ORDER: (context) => OrderPage(),
          AppRoutes.PRODUCT_MANAGER: (context) => ProductManagerPage(),
          AppRoutes.PRODUCT_MANAGER_FORM: (context) => ProductManagerFormPage(),
        },
      ),
    );
  }
}

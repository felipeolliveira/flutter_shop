import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/order_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_manager_page.dart';
import 'package:shop/pages/product_manager_form_page.dart';
import 'package:shop/pages/products_overview_page.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => new CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => new OrdersProvider(),
        )
      ],
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
            ),
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        routes: {
          AppRoutes.PRODUCT_OVERVIEW: (context) => ProductsOverviewPage(),
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

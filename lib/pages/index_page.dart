import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/providers/auth.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    print(auth.isAuth);

    return auth.isAuth ? ProductsOverviewPage() : AuthPage();
  }
}

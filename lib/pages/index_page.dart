import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/providers/auth.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        if (snapshot.error != null) {
          return Scaffold(
            body: Center(
              child: Text(
                  'Ocorreu um erro ao sincronizar os dados. Verifique sua internet.'),
            ),
          );
        }

        return auth.isAuth ? ProductsOverviewPage() : AuthPage();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  Widget _createTile(BuildContext context,
      {IconData icon, String title, String route}) {
    return Column(
      children: [
        Divider(),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(route);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo!'),
            elevation: 5,
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          // DrawerHeader(
          //   decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Padding(
          //       padding: const EdgeInsets.only(bottom: 18.0),
          //       child: Text('Bem Vindo!',
          //           style: Theme.of(context).primaryTextTheme.headline5),
          //     ),
          //   ),
          // ),
          _createTile(
            context,
            icon: Icons.shopping_bag_outlined,
            route: AppRoutes.PRODUCT_OVERVIEW,
            title: 'Loja',
          ),
          _createTile(
            context,
            icon: Icons.payment_rounded,
            route: AppRoutes.ORDER,
            title: 'Pedidos',
          ),
        ],
      ),
    );
  }
}

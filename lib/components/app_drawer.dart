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
          _createTile(
            context,
            icon: Icons.shopping_bag_outlined,
            route: AppRoutes.INDEX,
            title: 'Loja',
          ),
          _createTile(
            context,
            icon: Icons.payment_rounded,
            route: AppRoutes.ORDER,
            title: 'Pedidos',
          ),
          _createTile(
            context,
            icon: Icons.edit,
            route: AppRoutes.PRODUCT_MANAGER,
            title: 'Gerenciar Produtos',
          ),
        ],
      ),
    );
  }
}

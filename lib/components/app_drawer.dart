import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  Widget _createTile(BuildContext context,
      {IconData icon,
      String title,
      String route,
      Function onTap,
      Color color}) {
    return Column(
      children: [
        Divider(),
        ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            title,
            style: TextStyle(color: color),
          ),
          onTap: () {
            if (route == null) {
              if (onTap == null) {
                return;
              }
              onTap();
            } else {
              Navigator.of(context).pushReplacementNamed(route);
            }
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
          _createTile(
            context,
            icon: Icons.logout,
            color: Theme.of(context).errorColor,
            title: 'Sair',
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}

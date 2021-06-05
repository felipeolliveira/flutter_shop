import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/routes/app_routes.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context);

    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Pedidos'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.PRODUCT_OVERVIEW);
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: orders.itemsAmout,
          itemBuilder: (context, index) {
            return OrderItem(orders.items[index]);
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/providers/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.black),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          leading: CircleAvatar(
            child: Icon(Icons.local_shipping_rounded),
          ),
          title: Text(
            'R\$ ${order.amount.toStringAsFixed(2)}',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            DateFormat('dd MMM yyyy - HH:mm').format(order.date),
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          children: order.products.asMap().entries.map((entry) {
            var index = entry.key + 1;
            var product = entry.value;

            return Chip(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${index.toString()}. ${product.title}',
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                  ),
                  Text(
                    '${product.quantity} x R\$ ${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                  ),
                ],
              ),
              backgroundColor: Theme.of(context).backgroundColor,
            );
          }).toList(),
        ),
      ),
    );
  }
}

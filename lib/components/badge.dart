import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String itemCount;
  final Color color;

  Badge({
    this.child,
    this.color,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            constraints: BoxConstraints(minWidth: 15, minHeight: 16),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: color == null ? Theme.of(context).accentColor : color,
                borderRadius: BorderRadius.circular(
                  10,
                )),
            child: Text(
              itemCount,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

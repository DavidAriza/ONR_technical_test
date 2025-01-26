import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final num price;

  const ProductPrice({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${price.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.green, // Green for the price
      ),
    );
  }
}

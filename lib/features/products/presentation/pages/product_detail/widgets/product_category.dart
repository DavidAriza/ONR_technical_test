import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  final String category;

  const ProductCategory({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Category: $category',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}

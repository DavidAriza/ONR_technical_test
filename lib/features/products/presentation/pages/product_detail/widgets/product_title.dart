import 'package:flutter/material.dart';
import 'package:onr_technical_test/core/utils/app_colors.dart';

class ProductTitle extends StatelessWidget {
  final String title;

  const ProductTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}

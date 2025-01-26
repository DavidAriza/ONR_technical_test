import 'package:flutter/material.dart';
import 'package:onr_technical_test/core/utils/app_colors.dart';

class ProductRating extends StatelessWidget {
  final num rate;
  final int count;

  const ProductRating({
    super.key,
    required this.rate,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          '$rate ($count reviews)',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

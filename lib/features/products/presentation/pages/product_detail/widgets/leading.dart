import 'package:flutter/material.dart';

class Leading extends StatelessWidget {
  final VoidCallback onTap;
  const Leading({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 12,
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
        onPressed: onTap,
      ),
    );
  }
}

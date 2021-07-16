import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const CustomToast({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              label,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cash4cats/Extention/number_ext.dart'; // Only if you need `.width`
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditCartButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onTap;

  const EditCartButton({
    super.key,
    required this.isEditing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (!isEditing) SvgPicture.asset("assets/svg_icons/PencilLine.svg"),
          SizedBox(width: 1.width),
          Text(
            isEditing ? '' : 'Edit Cart',
            style: const TextStyle(
              color: Color(0xFF0053D2),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SendRequest extends StatelessWidget {
  final VoidCallback onTap;

  const SendRequest({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: const Color(0xFF0053D2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Send Request',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 1.55,
          ),
        ),
      ),
    );
  }
}

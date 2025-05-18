import 'package:flutter/material.dart';

class MyQuotations extends StatelessWidget {
  const MyQuotations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F6FA),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFB9B9B9),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'My Quotations',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF62656D),
          fontSize: 18,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

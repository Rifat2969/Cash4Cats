import 'package:cash4cats/Extention/number_ext.dart';
import 'package:flutter/material.dart';

import '../../../screens/categories.dart';

class BackToHomeButton extends StatelessWidget {
  const BackToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 428,
      height: 86,
      color: Colors.white,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Categories()),
          );
        },
        child: Container(
          width: 90.width,
          height: 56,
          decoration: ShapeDecoration(
            color: const Color(0xFF0053D2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Back to Home',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

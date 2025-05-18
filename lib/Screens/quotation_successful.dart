import 'package:cash4cats/Extention/number_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/categories.dart';

class QuotationSuccessful extends StatelessWidget {
  const QuotationSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg_icons/Group 18907.svg"),
            SizedBox(height: 2.height),
            const SizedBox(
              width: 272,
              child: Text(
                'Quotation Sent Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF303548),
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 1.height),
            const SizedBox(
              width: 380,
              child: Text(
                'Your quotation has been sent successfully. \nThe Dealer will contact you as soon as the product is ready.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF62656D),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),
            ),
            SizedBox(height: 2.height),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Categories()),
                  (route) => false,
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 5.height,
                width: 100.width,
                decoration: ShapeDecoration(
                  color: const Color(0xFF0053D2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text(
                  'Back to Home',
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
            ),
            SizedBox(height: 2.height),
            Container(
                alignment: Alignment.center,
                height: 5.height,
                width: 100.width,
                decoration: ShapeDecoration(
                  color: Colors.transparent, // Transparent background
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xFFB9B9B9), // Grey border
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Search Product',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF62656D),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.60,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

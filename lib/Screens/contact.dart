import 'package:cash4cats/Extention/number_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contact us',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF303548),
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset('assets/svg_icons/ContactUs.svg')),
            SizedBox(height: 1.4.height),
            const SizedBox(
              width: 272,
              child: Text(
                'Tell us How can we help you?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF303548),
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: .8.height),
            const SizedBox(
              width: 380,
              child: Text(
                'Contact our support team or send us an email to get support 24/7',
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
            SizedBox(height: 7.1.height),
            _contactButton(context),
            SizedBox(height: 3.2.height),
            _emailButton(context)
          ],
        ));
  }

  Widget _contactButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 380,
      height: 5.6.height,
      decoration: ShapeDecoration(
        color: const Color(0xFF0053D2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        'Contact support team',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _emailButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 380,
      height: 5.6.height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF0053D2)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'email @info@cash4cats.com',
        style: TextStyle(
          color: Color(0xFF303548),
          fontSize: 18,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

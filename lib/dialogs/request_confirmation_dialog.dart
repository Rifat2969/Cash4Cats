import 'package:cash4cats/Extention/number_ext.dart';
import 'package:cash4cats/Screens/quotation_successful.dart';
import 'package:flutter/material.dart';

class RequestConfirmationDialog extends StatelessWidget {
  final int totalItems;
  final double totalAmount;
  final VoidCallback onConfirm;

  const RequestConfirmationDialog({
    super.key,
    required this.totalItems,
    required this.totalAmount,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Request Confirmation',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.55,
              ),
            ),
            SizedBox(height: 1.height),
            const SizedBox(
              width: 304,
              child: Text(
                'Confirm your items before sending request to the dealer.',
                style: TextStyle(
                  color: Color(0xFF62656D),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),
            ),
            SizedBox(height: 1.height),
            const Divider(),
            SizedBox(height: 1.height),
            Text('Total Items: $totalItems'),
            SizedBox(height: 1.height),
            Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}'),
            SizedBox(height: 1.height),
            const Divider(),
            SizedBox(height: 1.height),
            const Text(
              'Add a note (optional)',
              style: TextStyle(
                color: Color(0xFF62656D),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.60,
              ),
            ),
            SizedBox(height: 1.height),
            Container(
              width: 304,
              height: 80,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: Color(0xFFDADEEB),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color(0xFF62656D),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.height),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const QuotationSuccessful()));
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
                  'Confirm Request',
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
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
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
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF62656D),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.60,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

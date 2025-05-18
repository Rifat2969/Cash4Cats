import 'package:cash4cats/Extention/number_ext.dart';
import 'package:flutter/material.dart';

import '../../model/cart_service.dart';
import 'buttons/my_quotations.dart';
import 'buttons/send_request.dart';

class CartBottomBar extends StatelessWidget {
  final Cart cart;
  final VoidCallback onSendRequest; // <- add this

  const CartBottomBar({super.key, required this.cart, required this.onSendRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _summaryRow('Items:', '${cart.totalItems}'),
          const SizedBox(height: 6),
          _summaryRow('Avg:', '\$${(cart.totalItems > 0 ? cart.totalAmount / cart.totalItems : 0).toStringAsFixed(2)}'),
          const SizedBox(height: 6),
          _summaryRow(
            'Total:',
            '\$${cart.totalAmount.toStringAsFixed(2)}',
            isBold: true,
            color: const Color(0xFF0053D2),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: MyQuotations()),
              SizedBox(width: 5.5.width),
              Expanded(
                child: SendRequest(
                  onTap: onSendRequest, // <- use the callback here
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}

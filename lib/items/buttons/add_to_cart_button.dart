import 'package:cash4cats/Extention/number_ext.dart';
import 'package:flutter/material.dart';

import '../../../model/cart_service.dart';
import '../../../model/products_api.dart';

class AddToCartButton extends StatelessWidget {
  final BuildContext context;
  final Cart cart;
  final ProductsApi products;
  final int index;

  const AddToCartButton({
    super.key,
    required this.context,
    required this.cart,
    required this.products,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.width,
      height: 38,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F6FA),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF0053D2)),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: InkWell(
        onTap: () {
          cart.addItem(products.data![index], products.data![index].quantity);
          ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(content: Text('${products.data![index].name} added to cart!')),
          );
        },
        child: const Text(
          'Add to Cart',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF0053D2),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 1.60,
          ),
        ),
      ),
    );
  }
}

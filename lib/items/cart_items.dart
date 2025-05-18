import 'package:flutter/material.dart';

import '../../model/cart_service.dart';
import 'buttons/quantity_selector.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final bool isEditing;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<bool?>? onCheckboxChanged;

  const CartItemTile({
    super.key,
    required this.item,
    required this.isEditing,
    required this.isSelected,
    required this.onTap,
    required this.onIncrement,
    required this.onDecrement,
    this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            if (isEditing)
              Checkbox(
                value: isSelected,
                onChanged: onCheckboxChanged,
              ),
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.product.catalogueImage != null
                    ? Image.network(
                        item.product.catalogueImage!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : const Center(child: Icon(Icons.image, size: 30)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name ?? 'Unknown Product',
                    style: const TextStyle(
                      color: Color(0xFF303548),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.product.price?.toStringAsFixed(2) ?? '0.00'} / per item',
                    style: const TextStyle(
                      color: Color(0xFF62656D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            isEditing
                ? QuantitySelector(
                    quantity: item.quantity,
                    onIncrement: onIncrement,
                    onDecrement: onDecrement,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${item.quantity} pcs',
                        style: const TextStyle(
                          color: Color(0xFF303548),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${item.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFF0053D2),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

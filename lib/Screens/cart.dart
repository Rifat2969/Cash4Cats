import 'package:flutter/material.dart';

import '../dialogs/request_confirmation_dialog.dart';
import '../items/buttons/edit_cart.dart';
import '../items/cart_appBar.dart';
import '../items/cart_bottom_bar.dart';
import '../items/cart_items.dart';
import '../model/cart_service.dart';

class CartPage extends StatefulWidget {
  final Cart cart;

  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isEditing = false;
  Set<int> selectedItemIds = {};
  Map<int, int> originalQuantities = {};

  void toggleSelection(int id) {
    setState(() {
      if (selectedItemIds.contains(id)) {
        selectedItemIds.remove(id);
      } else {
        selectedItemIds.add(id);
      }
    });
  }

  void deleteSelectedItems() {
    setState(() {
      for (var id in selectedItemIds) {
        widget.cart.removeItem(id);
      }
      selectedItemIds.clear();
    });
  }

  void startEditing() {
    setState(() {
      isEditing = true;
      originalQuantities.clear();
      for (var item in widget.cart.items) {
        originalQuantities[item.product.catalogueId!] = item.quantity;
      }
    });
  }

  void cancelEditing() {
    setState(() {
      isEditing = false;
      selectedItemIds.clear();
      for (var item in widget.cart.items) {
        final originalQuantity = originalQuantities[item.product.catalogueId!];
        item.quantity = originalQuantity!;
      }
    });
  }

  void doneEditing() {
    setState(() {
      isEditing = false;
      selectedItemIds.clear();
      originalQuantities.clear();
    });
  }

  void _showRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RequestConfirmationDialog(
          totalItems: widget.cart.totalItems,
          totalAmount: widget.cart.totalAmount,
          onConfirm: () {
            // 👉 Implement your submission logic here
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;

    return Scaffold(
      appBar: CartAppBar(
        isEditing: isEditing,
        hasSelectedItems: selectedItemIds.isNotEmpty,
        onDelete: deleteSelectedItems,
        onDone: doneEditing,
        onCancel: cancelEditing,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EditCartButton(
                        isEditing: isEditing,
                        onTap: () {
                          setState(() {
                            if (!isEditing) {
                              startEditing();
                            } else {
                              cancelEditing();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      final itemId = item.product.catalogueId!;
                      final isSelected = selectedItemIds.contains(itemId);

                      return CartItemTile(
                        item: item,
                        isEditing: isEditing,
                        isSelected: isSelected,
                        onTap: () {
                          if (isEditing) toggleSelection(itemId);
                        },
                        onIncrement: () {
                          setState(() {
                            item.quantity++;
                          });
                        },
                        onDecrement: () {
                          setState(() {
                            if (item.quantity > 1) item.quantity--;
                          });
                        },
                        onCheckboxChanged: (_) => toggleSelection(itemId),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CartBottomBar(
        cart: cart,
        onSendRequest: () => _showRequestDialog(context),
      ),
    );
  }
}

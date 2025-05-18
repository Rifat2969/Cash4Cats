import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEditing;
  final bool hasSelectedItems;
  final VoidCallback onDelete;
  final VoidCallback onDone;
  final VoidCallback onCancel;

  const CartAppBar({
    super.key,
    required this.isEditing,
    required this.hasSelectedItems,
    required this.onDelete,
    required this.onDone,
    required this.onCancel,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Cart'),
      actions: isEditing
          ? [
              if (hasSelectedItems)
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: onDone,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onCancel,
              ),
            ]
          : [],
    );
  }
}

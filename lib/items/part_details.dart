import 'package:flutter/material.dart';

import '../../model/part_details.dart';

class PartDetailsWidget extends StatelessWidget {
  final List<PartDetails> details;

  const PartDetailsWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: details.length,
      itemBuilder: (context, index) {
        var item = details[index];
        return Column(
          children: [
            Row(
              children: [
                Text(
                  item.specification ?? '',
                  style: const TextStyle(
                    color: Color(0xFF8D96AD),
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  item.ans ?? '',
                  style: const TextStyle(
                    color: Color(0xFF797A7D),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (index < details.length - 1) const Divider(),
          ],
        );
      },
    );
  }
}

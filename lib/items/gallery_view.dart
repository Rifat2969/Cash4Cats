import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryView extends StatelessWidget {
  final int totalImages;
  final int initialDisplay;
  final bool showAll;
  final VoidCallback onShowAll;

  const GalleryView({
    super.key,
    required this.totalImages,
    required this.initialDisplay,
    required this.showAll,
    required this.onShowAll,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: showAll ? totalImages : initialDisplay,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        if (!showAll && index == initialDisplay - 1) {
          int remainingCount = totalImages - initialDisplay;
          return GestureDetector(
            onTap: onShowAll,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/i${index + 1}.jpg', fit: BoxFit.cover),
                Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Center(
                    child: Text(
                      "+$remainingCount More",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/images/i${index + 1}.jpg', fit: BoxFit.cover),
        );
      },
    );
  }
}

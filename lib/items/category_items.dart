import 'package:cash4cats/Extention/number_ext.dart';
import 'package:cash4cats/Screens/products.dart';
import 'package:flutter/material.dart';

import '../model/category_data.dart';

class CategoryItems extends StatelessWidget {
  final List<CategoryData> categories;
  const CategoryItems({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 3.height),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        var category = categories[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Products(category: category)),
            );
          },
          child: Column(
            children: [
              Container(
                width: 16.width,
                height: 8.height,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 1, color: const Color(0xFFCCCCCC)),
                ),
                child: Center(
                  child: Image.network(
                    category.image ?? 'https://via.placeholder.com/100',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                maxLines: 1,
                category.name ?? "Unknown",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

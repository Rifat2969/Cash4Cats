import 'package:cash4cats/Extention/number_ext.dart';
import 'package:cash4cats/Screens/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../items/category_items.dart';
import '../items/pgm_price_strip.dart';
import '../items/top_bar.dart';
import '../model/cart_service.dart';
import '../provider/category_provider.dart';
import '../utils/size_config.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final Cart cart = Cart();
  var viewModel = CategoryProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).initData();
    });
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<CategoryProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initMediaQuery(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopBar(cart: cart),
            SizedBox(height: 3.height),
            _searchBar(viewModel),
            SizedBox(height: 1.72.height),
            const Text(
              'All Categories',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF303548),
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
                child: viewModel.loader
                    ? const Center(child: CircularProgressIndicator())
                    : viewModel.filteredCategories.isEmpty
                        ? const Center(child: Text("No categories found"))
                        : CategoryItems(categories: viewModel.filteredCategories)),
            const Divider(),
            PgmPriceStrip(loader: viewModel.loader, pgmlist: viewModel.pgmlist),
          ],
        ),
      ),
    );
  }

  Widget _searchBar(CategoryProvider viewModel) {
    return Container(
      height: 6.height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: viewModel.searchController,
              onChanged: (value) => viewModel.filterCategories(value),
              decoration: const InputDecoration(
                hintText: 'Search by Brand, Item code',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Filter()),
              );
            },
            child: SvgPicture.asset(
              "assets/svg_icons/Frame 18964.svg",
              width: 40,
              height: 40,
            ),
          )
        ],
      ),
    );
  }
}

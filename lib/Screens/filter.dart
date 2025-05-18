import 'package:cash4cats/Extention/number_ext.dart';
import 'package:cash4cats/Screens/filter_result.dart';
import 'package:cash4cats/model/category_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../items/top_bar.dart';
import '../model/cart_service.dart';
import '../provider/category_provider.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final Cart cart = Cart();
  List<CategoryData> selectedCategories = [];
  bool showAllCategories = false;
  TextEditingController searchController = TextEditingController();
  List<CategoryData> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final query = searchController.text.toLowerCase();
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    setState(() {
      filteredCategories = (provider.categories.data ?? [])
          .where((category) => category.name?.toLowerCase().contains(query) ?? false)
          .toList();
    });
  }

  void _resetFilters() {
    setState(() {
      selectedCategories = [];
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    List<CategoryData> displayCategories =
        showAllCategories ? filteredCategories : filteredCategories.take(10).toList();

    // Initialize filteredCategories once when categories loaded
    if (!categoryProvider.loader && filteredCategories.isEmpty && (categoryProvider.categories.data ?? []).isNotEmpty) {
      filteredCategories = categoryProvider.categories.data!;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(cart: cart),
              const SizedBox(height: 10),
              _buildSearchBar(),
              const SizedBox(height: 32),
              _buildHeader(categoryProvider),
              const SizedBox(height: 24),
              Expanded(child: _buildCategoryList(categoryProvider)),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF303548), size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search brands...',
                hintStyle: TextStyle(color: Color(0xFF303548)),
                border: InputBorder.none,
              ),
            ),
          ),
          if (searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                _filterCategories();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(CategoryProvider provider) {
    return Row(
      children: [
        const Text('Brand',
            style: TextStyle(
              color: Color(0xFF303548),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(width: 10),
        const Text('(Select multiple)',
            style: TextStyle(
              color: Color(0xFF62656D),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.6,
            )),
        const Spacer(),
        if (filteredCategories.length > 10)
          GestureDetector(
            onTap: () {
              setState(() {
                showAllCategories = !showAllCategories;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Text(
                showAllCategories ? 'See less' : 'See all',
                style: const TextStyle(
                  color: Color(0xFF0053D2),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryList(CategoryProvider provider) {
    if (provider.loader) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filteredCategories.isEmpty) {
      return const Center(child: Text("No brands found"));
    }

    List<CategoryData> displayCategories =
        showAllCategories ? filteredCategories : filteredCategories.take(10).toList();

    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: displayCategories.map((category) {
            final isSelected = selectedCategories.contains(category);

            return InkWell(
              onTap: () {
                setState(() {
                  isSelected ? selectedCategories.remove(category) : selectedCategories.add(category);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0053D2).withOpacity(0.1) : Colors.white,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF0053D2) : const Color(0xFFCCCCCC),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category.name ?? "Unknown",
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF0053D2) : Colors.black,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: _resetFilters,
            child: Container(
              height: 5.height,
              width: 30.width,
              decoration: ShapeDecoration(
                color: const Color(0xFFF6F6FA),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFB9B9B9)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg_icons/ArrowClockwise.svg", height: 20, width: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Reset',
                    style: TextStyle(
                      color: Color(0xFF62656D),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (selectedCategories.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterResult(categories: selectedCategories),
                  ),
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 45.width,
              height: 5.height,
              decoration: ShapeDecoration(
                color: selectedCategories.isEmpty ? const Color(0xFF0053D2).withOpacity(0.5) : const Color(0xFF0053D2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'Show Results',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

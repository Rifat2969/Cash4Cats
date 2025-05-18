import 'package:cash4cats/Extention/number_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../items/buttons/add_to_cart_button.dart';
import '../items/buttons/back_to_home_button.dart';
import '../items/buttons/quantity_selector.dart';
import '../items/top_bar.dart';
import '../model/category_data.dart';
import '../provider/filter_result_provider.dart';
import '../screens/product_details.dart';

class FilterResult extends StatefulWidget {
  final List<CategoryData> categories;

  const FilterResult({super.key, required this.categories});

  @override
  State<FilterResult> createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  var viewModel = FilterResultProvider();

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<FilterResultProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FilterResultProvider>(context, listen: false).fetchFilteredProducts(widget.categories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FilterResultProvider>(
          builder: (context, provider, child) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(cart: provider.cart),
                const SizedBox(height: 40),
                _buildSearchBar(),
                SizedBox(height: 3.2.height),
                Text(
                  "${provider.totalProductCount} products found from your result",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF303548),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: provider.loader
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: widget.categories.length,
                          itemBuilder: (context, categoryIndex) {
                            var category = widget.categories[categoryIndex];
                            var categoryProducts = provider.allProducts[categoryIndex].data;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Products for ${category.name}",
                                  style: const TextStyle(
                                    color: Color(0xFF303548),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                (categoryProducts == null || categoryProducts.isEmpty)
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 20),
                                          child: Text("No products available"),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: categoryProducts.length,
                                        itemBuilder: (context, productIndex) {
                                          var product = categoryProducts[productIndex];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const ProductDetails()),
                                              );
                                            },
                                            child: _buildProductCard(product, categoryIndex, productIndex, provider),
                                          );
                                        },
                                      ),
                              ],
                            );
                          },
                        ),
                ),
                const BackToHomeButton(),
              ],
            ),
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
          const Icon(Icons.search, color: Colors.black54, size: 30),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by Brand, Item code',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          SvgPicture.asset("assets/svg_icons/Frame 18964.svg", width: 40, height: 40),
        ],
      ),
    );
  }

  Widget _buildProductCard(product, int categoryIndex, int productIndex, FilterResultProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 33),
      height: 43.height,
      width: 100.width,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFDEE2EF)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product.catalogueImage == null
              ? Container()
              : Image.network(
                  product.catalogueImage ?? "https://via.placeholder.com/100",
                  width: 100.width,
                  height: 235,
                  fit: BoxFit.fill,
                  errorBuilder: (a, b, c) => Container(),
                ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      product.categoryImage ?? "https://via.placeholder.com/100",
                      width: 20,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        product.name ?? "Unknown",
                        style: const TextStyle(
                          color: Color(0xFF303548),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '\$${((product.price ?? 0) * product.quantity).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF0053D2),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Text(
                      '/ Per item',
                      style: TextStyle(
                        color: Color(0xFF62656D),
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    QuantitySelector(
                      quantity: product.quantity,
                      onIncrement: () => provider.incrementQuantity(categoryIndex, productIndex),
                      onDecrement: () => provider.decrementQuantity(categoryIndex, productIndex),
                    ),
                    const Spacer(),
                    AddToCartButton(
                      context: context,
                      cart: provider.cart,
                      products: provider.allProducts[categoryIndex],
                      index: productIndex,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

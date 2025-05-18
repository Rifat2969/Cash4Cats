import 'package:cash4cats/Screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Extention/number_ext.dart';
import '../items/buttons/add_to_cart_button.dart';
import '../items/buttons/back_to_home_button.dart';
import '../items/buttons/quantity_selector.dart';
import '../items/top_bar.dart';
import '../model/cart_service.dart';
import '../model/category_data.dart';
import '../provider/products_provider.dart';

class Products extends StatefulWidget {
  final CategoryData category;
  const Products({super.key, required this.category});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final Cart cart = Cart();
  var viewModel = ProductsProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initViewModel(widget.category.id!);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final provider = Provider.of<ProductsProvider>(context);
    if (viewModel != provider) {
      viewModel = provider;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(cart: cart),
              const SizedBox(height: 40),
              _searchBar(),
              SizedBox(height: 3.2.height),
              Text(
                "All Products for ${widget.category.name}",
                style: const TextStyle(
                  color: Color(0xFF303548),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${viewModel.products.data?.length ?? 0} items found for ${widget.category.name}',
                style: const TextStyle(
                  color: Color(0xFF62656D),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: viewModel.loader ? const Center(child: CircularProgressIndicator()) : _products(viewModel),
              ),
              const BackToHomeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _products(ProductsProvider viewModel) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: viewModel.products.data?.length ?? 0,
      itemBuilder: (context, index) {
        var product = viewModel.products.data![index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductDetails()),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 33),
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
                if (product.catalogueImage != null)
                  Image.network(
                    product.catalogueImage!,
                    width: double.infinity,
                    height: 235,
                    fit: BoxFit.fill,
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
                                color: Colors.black,
                                fontSize: 14,
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Text(
                            '/ Per item',
                            style: TextStyle(
                              color: Color(0xFF62656D),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          QuantitySelector(
                            quantity: product.quantity,
                            onIncrement: () => viewModel.incrementQuantity(index),
                            onDecrement: () => viewModel.decrementQuantity(index),
                          ),
                          const Spacer(),
                          AddToCartButton(
                            context: context,
                            cart: cart,
                            products: viewModel.products,
                            index: index,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.black54, size: 30),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by Brand, Item code',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

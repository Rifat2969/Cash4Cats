import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../items/buttons/quantity_selector.dart';
import '../items/carousel_image_viewer.dart';
import '../items/gallery_view.dart';
import '../items/part_details.dart';
import '../model/part_details.dart';
import '../provider/product_details_provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var viewModel = ProductDetailsProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<ProductDetailsProvider>(context);
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
        child: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CarouselImageViewer(),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/bmw-car-logo-735811696610457s9siw7ivja.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'AK1233 BG34',
                          style: TextStyle(
                            color: Color(0xFF303548),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '27 items available',
                      style: TextStyle(
                        color: Color(0xFF62656D),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Text(
                          'price',
                          style: TextStyle(
                            color: Color(0xFF0053D2),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text(
                          '/ Per item',
                          style: TextStyle(
                            color: Color(0xFF62656D),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Divider(),
                    const SizedBox(height: 32),
                    const Text(
                      'About',
                      style: TextStyle(
                        color: Color(0xFF303548),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const SizedBox(
                      width: 380,
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        style: TextStyle(
                          color: Color(0xFF62656D),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          'Read more',
                          style: TextStyle(
                            color: Color(0xFF0053D2),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Color(0xFF0053D2))
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Part Details',
                      style: TextStyle(
                        color: Color(0xFF303548),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PartDetailsWidget(details: all_details),
                    const SizedBox(height: 32),
                    const Text(
                      'Gallery',
                      style: TextStyle(
                        color: Color(0xFF303548),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GalleryView(
                      totalImages: viewModel.totalImages,
                      initialDisplay: viewModel.initialDisplay,
                      showAll: viewModel.showAll,
                      onShowAll: viewModel.showAllImages,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 80,
            alignment: Alignment.center,
            child: Row(
              children: [
                QuantitySelector(
                  quantity: viewModel.quantity,
                  onIncrement: viewModel.incrementUnit,
                  onDecrement: viewModel.decrementUnit,
                ),
                const SizedBox(width: 20),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0053D2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: viewModel.activeIndex,
        count: 5,
        effect: const JumpingDotEffect(
          activeDotColor: Colors.white,
          dotColor: Colors.grey,
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}

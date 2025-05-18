import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselImageViewer extends StatefulWidget {
  const CarouselImageViewer({super.key});

  @override
  State<CarouselImageViewer> createState() => _CarouselImageViewerState();
}

class _CarouselImageViewerState extends State<CarouselImageViewer> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) => setState(() => activeIndex = index),
            height: 400.0,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
          ),
          items: List.generate(5, (index) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/i${index + 1}.jpg',
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }),
        ),
        Positioned(bottom: 20, child: buildIndicator()),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const JumpingDotEffect(
          activeDotColor: Colors.white,
          dotColor: Colors.grey,
          dotHeight: 10,
          dotWidth: 10,
        ),
      );
}

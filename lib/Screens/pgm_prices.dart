import 'package:cash4cats/model/pgm_price_api.dart';
import 'package:cash4cats/repository/pgm_price_repo.dart';
import 'package:flutter/material.dart';

import '../items/top_bar.dart';
import '../model/cart_service.dart';

class PgmPrices extends StatefulWidget {
  const PgmPrices({super.key});

  @override
  State<PgmPrices> createState() => _PgmPricesState();
}

class _PgmPricesState extends State<PgmPrices> {
  bool loader = true;
  PgmPriceAPI pgmprices = PgmPriceAPI();
  List<int> pgmlist = [];
  final List<String> items = ['All prices', 'PT', 'PD', 'RH'];
  int selectedIndex = 0;
  final PageController _pageController = PageController();
  final Cart cart = Cart();
  @override
  void initState() {
    _getPgmPrice();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _getPgmPrice() async {
    var response = await PgmPriceRepository().fetchPgmPrices();
    if (response != null) {
      setState(() => pgmprices = response);
      pgmlist.add(pgmprices.data?.pt ?? 0);
      pgmlist.add(pgmprices.data?.pd ?? 0);
      pgmlist.add(pgmprices.data?.rh ?? 0);
      setState(() {});
    }
    loader = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your existing header row
              TopBar(cart: cart),
              const SizedBox(height: 40),
              const Text(
                'PGM Price Rates',
                style: TextStyle(
                  color: Color(0xFF303548),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              // Your tab buttons
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 81,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF0053D2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF0053D2) : Colors.grey,
                          ),
                        ),
                        child: Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // PageView with your list design
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  children: [
                    _buildAllPricesPage(),
                    _buildSinglePricePage(0),
                    _buildSinglePricePage(1),
                    _buildSinglePricePage(2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllPricesPage() {
    if (loader) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pgmlist.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Text(
                    index == 0
                        ? "PT"
                        : index == 1
                            ? "PD"
                            : "RH",
                    style: TextStyle(
                      color: index == 0
                          ? Colors.blue
                          : index == 1
                              ? Colors.red
                              : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$ ',
                        style: TextStyle(
                          color: index == 0
                              ? Colors.blue
                              : index == 1
                                  ? Colors.red
                                  : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        pgmlist.isEmpty ? '0' : '${pgmlist[index]}',
                        style: TextStyle(
                          color: index == 0
                              ? Colors.blue
                              : index == 1
                                  ? Colors.red
                                  : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (index != pgmlist.length - 1)
              const Divider(
                thickness: 1,
                color: Color(0xFFE3E3E3),
                indent: 16,
                endIndent: 16,
              ),
          ],
        );
      },
    );
  }

  Widget _buildSinglePricePage(int index) {
    if (loader) {
      return const Center(child: CircularProgressIndicator());
    }

    if (pgmlist.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            index == 0
                ? "PT"
                : index == 1
                    ? "PD"
                    : "RH",
            style: TextStyle(
              color: index == 0
                  ? Colors.blue
                  : index == 1
                      ? Colors.red
                      : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$ ',
                style: TextStyle(
                  color: index == 0
                      ? Colors.blue
                      : index == 1
                          ? Colors.red
                          : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                pgmlist.isEmpty ? '0' : '${pgmlist[index]}',
                style: TextStyle(
                  color: index == 0
                      ? Colors.blue
                      : index == 1
                          ? Colors.red
                          : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

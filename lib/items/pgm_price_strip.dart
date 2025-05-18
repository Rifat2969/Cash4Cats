import 'package:cash4cats/Extention/number_ext.dart';
import 'package:flutter/material.dart';

import '../../Screens/pgm_prices.dart';

class PgmPriceStrip extends StatelessWidget {
  final bool loader;
  final List<int> pgmlist;

  const PgmPriceStrip({super.key, required this.loader, required this.pgmlist});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loader
          ? const CircularProgressIndicator()
          : SizedBox(
              height: 78,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: pgmlist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PgmPrices()));
                    },
                    child: Container(
                      height: 8.height,
                      width: 25.width,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            index == 0
                                ? "PT"
                                : index == 1
                                    ? "PD"
                                    : index == 2
                                        ? "RH"
                                        : "Other",
                            style: TextStyle(
                              color: index == 0
                                  ? Colors.blue
                                  : index == 1
                                      ? Colors.red
                                      : index == 2
                                          ? Colors.black
                                          : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'AUD\$ ',
                                style: TextStyle(
                                  color: (index == 0)
                                      ? Colors.blue
                                      : (index == 1)
                                          ? Colors.red
                                          : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                pgmlist.isEmpty ? '0' : '${pgmlist[index]}',
                                style: TextStyle(
                                  color: (index == 0)
                                      ? Colors.blue
                                      : (index == 1)
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
                  );
                },
              ),
            ),
    );
  }
}

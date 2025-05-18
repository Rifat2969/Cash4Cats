import 'package:cash4cats/provider/category_provider.dart';
import 'package:cash4cats/provider/filter_result_provider.dart';
import 'package:cash4cats/provider/login_provider.dart';
import 'package:cash4cats/provider/product_details_provider.dart';
import 'package:cash4cats/provider/products_provider.dart';
import 'package:cash4cats/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ChangeNotifierProvider(create: (_) => ProductsProvider()),
  ChangeNotifierProvider(create: (_) => FilterResultProvider()),
  ChangeNotifierProvider(create: (_) => ProfileProvider()),
  ChangeNotifierProvider(create: (_) => ProductDetailsProvider()),
];

import 'package:almasah_dates/features/items/presentation/screens/item_list_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const itemList = '/items';
  static const itemDetails = '/items/details';

  static Map<String, WidgetBuilder> routes = {
    itemList: (context) => const ItemListScreen(),
  };
}

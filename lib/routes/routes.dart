import 'package:almasah_dates/features/auth/presentation/screens/login_page.dart';
import 'package:almasah_dates/features/auth/presentation/screens/registration_page.dart';
import 'package:almasah_dates/features/customer/presentation/screens/customer_list_screen.dart';
import 'package:almasah_dates/features/home/presentation/screens/home_page.dart';
import 'package:almasah_dates/features/items/presentation/screens/item_list_screen.dart';
import 'package:almasah_dates/features/marchent/presentation/screens/merchant_list_screen.dart';
import 'package:almasah_dates/features/purchaseOrder/presentation/screens/purchaseOrder_screen.dart';
import 'package:almasah_dates/features/saleOrder/presentation/screens/saleOrder_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const itemList = '/items';
  static const itemDetails = '/items/details';

  static const Login = '/login';
  static const Registration = '/registration';
  static const MyHome = '/home';
  static const merchantList = '/merchants';
  static const customerList = '/customers';
  static const purchaseOrderList = '/purchaseOrder';
  static const saleOrderList = '/saleOrder';

  static Map<String, WidgetBuilder> routes = {
    Login: (context) => const LoginPage(),
    Registration: (context) => const RegistrationPage(),
    MyHome: (context) => MyHomePage(),
    itemList: (context) => ItemListScreen(),
    merchantList: (context) => MerchantListScreen(),
    customerList: (context) => CustomerListScreen(),
    purchaseOrderList: (context) => PurchaseOrderListScreen(),
    saleOrderList: (context) => SaleOrderListScreen(),
  };
}

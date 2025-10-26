import 'package:almasah_dates/features/items/presentation/providers/item_provider.dart';
import 'package:almasah_dates/core/theme/theme.dart';
import 'package:almasah_dates/features/marchent/presentation/providers/merchant_provider.dart';
import 'package:almasah_dates/features/purchaseOrder/presentation/providers/purchaseOrder_provider.dart';
import 'package:almasah_dates/routes/routes.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getnext() {
    current = WordPair.random();
    notifyListeners();
  }

  var fav = <WordPair>[];
  void togglefavs() {
    if (fav.contains(current)) {
      fav.remove(current);
    } else {
      fav.add(current);
    }
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAppState()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (_) => MerchantProvider()),
        ChangeNotifierProvider(create: (_) => PurchaseOrderProvider()),
      ],
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          // scaffoldBackgroundColor: Colors.lightBlueAccent.shade100,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurpleAccent.shade100,
secondary: Colors.amber,
            // TRY THIS: Change to "Brightness.light"
            //           and see that all colors change
            //           to better contrast a light background.
            brightness: Brightness.light,
          ),
          // textTheme: TextTheme(
          //   displayLarge: const TextStyle(
          //     fontSize: 22,
          //     fontWeight: FontWeight.bold,
          //   ),
          //             titleLarge: GoogleFonts.oswald(
          //   fontSize: 30,
          //   fontStyle: FontStyle.italic,
          // ),
          // bodyMedium: GoogleFonts.merriweather(),
          // displaySmall: GoogleFonts.pacifico(),
        
          ),

          // colorSchemeSeed:
        // ThemeData.light(),//Theme.darkTheme,
        initialRoute: '/login',
        routes: AppRoutes.routes,
      ),
    );
  }
}

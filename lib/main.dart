import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: "Shopping App",
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Lato',
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(fontSize: 20, color: Colors.black)),
            textTheme: const TextTheme(
              titleMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              bodySmall: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
                prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
                hintStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            colorScheme: ColorScheme.fromSeed(
                primary: const Color.fromRGBO(254, 206, 1, 1),
                seedColor: const Color.fromRGBO(254, 206, 1, 1))),
        debugShowCheckedModeBanner: false,
        // home: ProductDetailsPage(product: products[0]),
        home: const HomePage(),
      ),
    );
  }
}

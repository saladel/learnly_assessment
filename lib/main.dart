import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnly_assessment/models/product_model.dart';
import 'package:learnly_assessment/providers/api_provider.dart';
import 'package:learnly_assessment/providers/cart_provider.dart';
import 'package:learnly_assessment/screens/cart_screen.dart';
import 'package:learnly_assessment/screens/home_screen.dart';
import 'package:learnly_assessment/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// routes
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return HomeScreen();
      },
      routes: [
        // productdetail route
        GoRoute(
          path: 'productdetail',
          builder: (context, state) {
            final product = state.extra as Product;
            return ProductDetailScreen(product: product);
          },
        ),
      ],
    ),
    // cart screen route
    GoRoute(
      path: '/cart',
      builder: (context, state) {
        return CartScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      //create: (context) => ApiProvider(),
      child: MaterialApp.router(
        title: 'Learnly Assessment',
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

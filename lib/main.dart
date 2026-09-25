import 'package:flutter/material.dart';
import 'screens/shop_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const PetoteApp());

class PetoteApp extends StatelessWidget {
  const PetoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pétote — Le goût du Nord',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const ShopScreen(),
    );
  }
}

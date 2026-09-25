import 'package:flutter/material.dart';
import '../data/product_styles.dart';

/// Un seul widget affiche les images locales, sans téléchargement.
class ProductVisual extends StatelessWidget {
  final ProductStyle style;
  final double height;

  const ProductVisual({super.key, required this.style, this.height = 290});

  @override
  Widget build(BuildContext context) => Image.asset(
    style.imageAsset,
    height: height,
    fit: BoxFit.contain,
    semanticLabel: 'Packaging ${style.shortName}, visuel généré',
    errorBuilder: (context, error, stackTrace) => SizedBox(
      height: height,
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined, size: 36),
      ),
    ),
  );
}

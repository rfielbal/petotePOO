import 'package:flutter/material.dart';

/// Les informations graphiques restent séparées des classes métier.
class ProductStyle {
  final Color color;
  final String shortName;
  final String imageAsset;

  const ProductStyle({
    required this.color,
    required this.shortName,
    required this.imageAsset,
  });
}

const productStyles = <String, ProductStyle>{
  'PT-001': ProductStyle(
    color: Color(0xFFB48B2D),
    shortName: 'Nature',
    imageAsset: 'assets/images/chips_nature.png',
  ),
  'PT-002': ProductStyle(
    color: Color(0xFFA45036),
    shortName: 'Andouillette & Maroilles',
    imageAsset: 'assets/images/chips_maroilles.png',
  ),
  'PT-003': ProductStyle(
    color: Color(0xFF55764D),
    shortName: 'Gaufre lilloise',
    imageAsset: 'assets/images/chips_gaufre.png',
  ),
  'PT-004': ProductStyle(
    color: Color(0xFF527E80),
    shortName: 'Bêtise de Cambrai',
    imageAsset: 'assets/images/chips_cambrai.png',
  ),
};

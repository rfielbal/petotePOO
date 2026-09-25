import 'package:flutter/material.dart';
import '../data/product_styles.dart';
import '../models/chips_ondulees.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'common_widgets.dart';
import 'product_visual.dart';

class ProductCard extends StatelessWidget {
  final ChipsOndulees produit;
  final VoidCallback onOpen;

  const ProductCard({super.key, required this.produit, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final style = productStyles[produit.reference]!;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: AppColors.photo,
            child: InkWell(
              onTap: onOpen,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 28, 16, 8),
                      child: ProductVisual(style: style),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    left: 14,
                    child: LabelBadge(produit.unGout.type.toUpperCase()),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 3, color: style.color),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${produit.reference}  ·  ${produit.poids} g',
                  style: const TextStyle(
                    fontSize: 11,
                    letterSpacing: 1,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 10),
                // Une hauteur minimale aligne les prix, sans bloquer le texte agrandi.
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 58),
                  child: Text(
                    style.shortName,
                    style: const TextStyle(
                      fontSize: 23,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.7,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      euros(produit.prix),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      '${euros(produit.calculerPrixAuKilo())} / kg',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onOpen,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text('Découvrir')),
                        Icon(Icons.arrow_forward_rounded, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<ChipsOndulees> produits;
  final void Function(ChipsOndulees) onOpen;

  const ProductGrid({super.key, required this.produits, required this.onOpen});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns = constraints.maxWidth >= 1000
          ? 4
          : constraints.maxWidth >= 530
          ? 2
          : 1;
      final width = (constraints.maxWidth - (columns - 1) * 20) / columns;
      return Wrap(
        spacing: 20,
        runSpacing: 24,
        children: produits
            .map(
              (p) => SizedBox(
                width: width,
                child: ProductCard(produit: p, onOpen: () => onOpen(p)),
              ),
            )
            .toList(),
      );
    },
  );
}

import 'package:flutter/material.dart';
import '../data/product_styles.dart';
import '../theme/app_theme.dart';
import 'product_visual.dart';

class CatalogueHero extends StatelessWidget {
  final VoidCallback onDiscover;
  const CatalogueHero({super.key, required this.onDiscover});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide = constraints.maxWidth >= 780;
      final copy = Padding(
        padding: EdgeInsets.all(wide ? 44 : 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.yellow,
                  size: 16,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'DOUAI · DEPUIS 2019',
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Text(
              'Les ondulées\ndu Nord.',
              style: TextStyle(
                fontSize: wide ? 62 : 42,
                height: 1.02,
                letterSpacing: -2.4,
                fontWeight: FontWeight.w800,
                color: AppColors.cream,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Des chips de pommes de terre en petites séries, inspirées des spécialités de notre région.',
              style: TextStyle(
                color: Color(0xFFDDE5D8),
                fontSize: 15,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.yellow,
                foregroundColor: AppColors.ink,
              ),
              onPressed: onDiscover,
              label: const Text('Explorer les saveurs'),
              icon: const Icon(Icons.arrow_downward_rounded, size: 18),
            ),
          ],
        ),
      );
      final photo = Container(
        height: wide ? 440 : 310,
        width: double.infinity,
        color: AppColors.photo,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ProductVisual(
              style: productStyles['PT-001']!,
              height: wide ? 422 : 296,
            ),
            Positioned(
              right: 18,
              bottom: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.line),
                ),
                child: const Text(
                  'NATURE  /  125 g',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(24),
        ),
        child: wide
            ? Row(
                children: [
                  Expanded(flex: 6, child: copy),
                  Expanded(flex: 5, child: photo),
                ],
              )
            : Column(children: [copy, photo]),
      );
    },
  );
}

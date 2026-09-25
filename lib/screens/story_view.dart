import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const PageHeading(
        eyebrow: 'UNE HISTOIRE DE CHEZ NOUS',
        title: 'Petite série.\nGrand caractère.',
        subtitle: 'Pétote, les spécialités du Nord autrement.',
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on_outlined, color: AppColors.yellow, size: 34),
            SizedBox(height: 22),
            Text(
              'Née à Douai,\nancrée dans le Nord.',
              style: TextStyle(
                fontSize: 33,
                height: 1.1,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Fondée en 2019, Pétote est une entreprise familiale des Hauts-de-France, aux portes du pays du Maroilles. Elle fabrique en petites séries des chips de pommes de terre ondulées, inspirées des grandes spécialités régionales.',
              style: TextStyle(
                color: Color(0xFFD4DDCD),
                height: 1.8,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      const Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _StoryFact(
            icon: Icons.family_restroom_outlined,
            title: 'Depuis 2019',
            text: 'Une entreprise familiale.',
          ),
          _StoryFact(
            icon: Icons.grain_rounded,
            title: 'En petites séries',
            text: 'Des chips de pommes de terre ondulées.',
          ),
          _StoryFact(
            icon: Icons.storefront_outlined,
            title: 'Près de chez vous',
            text: 'Sur les marchés locaux et la boutique en ligne.',
          ),
        ],
      ),
      const SizedBox(height: 32),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: const Color(0xFFF1E7D0),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelBadge('À VENIR'),
            SizedBox(height: 18),
            Text(
              'La famille va\ns’agrandir.',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
                height: 1.1,
              ),
            ),
            SizedBox(height: 14),
            Text(
              'La frite ondulée nature arrive en sachet de 500 g. Deux coupes prévues : fine ou épaisse.',
              style: TextStyle(height: 1.6),
            ),
            SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                LabelBadge('NATURE'),
                LabelBadge('500 G'),
                LabelBadge('FINE / ÉPAISSE'),
              ],
            ),
            SizedBox(height: 14),
            Text(
              'Date de lancement et prix non communiqués.',
              style: TextStyle(color: AppColors.muted, fontSize: 12),
            ),
          ],
        ),
      ),
    ],
  );
}

class _StoryFact extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _StoryFact({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 250,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(color: AppColors.muted, height: 1.6),
          ),
        ],
      ),
    ),
  );
}

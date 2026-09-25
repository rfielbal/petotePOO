import 'package:flutter/material.dart';
import '../data/product_styles.dart';
import '../models/chips_ondulees.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/common_widgets.dart';
import '../widgets/product_visual.dart';

class ProductDetail extends StatefulWidget {
  final ChipsOndulees produit;
  const ProductDetail({super.key, required this.produit});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  // Simulation uniquement : aucune promotion inventée n'est activée au départ.
  double remise = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.produit;
    final style = productStyles[p.reference]!;
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: AppColors.cream,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 920),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 700;
              final photo = Container(
                width: double.infinity,
                color: AppColors.photo,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ProductVisual(style: style, height: wide ? 470 : 260),
              );
              final information = Padding(
                padding: const EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelBadge(
                      '${p.reference} · ${p.unGout.type.toUpperCase()}',
                      color: style.color.withValues(alpha: 0.12),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      p.nom,
                      style: const TextStyle(
                        fontSize: 28,
                        height: 1.15,
                        letterSpacing: -1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 22),
                    _ProductFact(label: 'Goût', value: p.unGout.nom),
                    _ProductFact(label: 'Poids net', value: '${p.poids} g'),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 16,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          euros(p.prix),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '${euros(p.calculerPrixAuKilo())} / kg',
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBEEDF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Simuler une remise',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Le prix du catalogue reste inchangé.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color: AppColors.muted,
                            ),
                          ),
                          Slider(
                            value: remise,
                            min: 0,
                            max: 100,
                            divisions: 20,
                            label: '${remise.round()} %',
                            semanticFormatterCallback: (value) =>
                                '${value.round()} pour cent de remise',
                            onChanged: (value) =>
                                setState(() => remise = value),
                          ),
                          Wrap(
                            spacing: 24,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                'Remise : ${remise.round()} %',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                euros(p.obtenirPrixPromo(remise)),
                                key: const ValueKey('promo-price'),
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 8, 4),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'LA FICHE PRODUIT',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 2,
                              color: AppColors.muted,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          tooltip: 'Fermer la fiche',
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  if (wide)
                    Row(
                      children: [
                        Expanded(flex: 4, child: photo),
                        Expanded(flex: 5, child: information),
                      ],
                    )
                  else ...[
                    photo,
                    information,
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProductFact extends StatelessWidget {
  final String label;
  final String value;
  const _ProductFact({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 78,
          child: Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import '../models/catalogue.dart';
import '../models/chips_ondulees.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/catalogue_hero.dart';
import '../widgets/common_widgets.dart';
import '../widgets/product_card.dart';
import 'product_detail.dart';

enum SortOrder { catalogue, priceAscending, priceDescending }

class CatalogueView extends StatefulWidget {
  final Catalogue catalogue;
  const CatalogueView({super.key, required this.catalogue});

  @override
  State<CatalogueView> createState() => _CatalogueViewState();
}

class _CatalogueViewState extends State<CatalogueView> {
  final searchController = TextEditingController();
  final productsKey = GlobalKey();
  String filtre = 'Tout';
  String recherche = '';
  SortOrder tri = SortOrder.catalogue;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// On filtre une copie de la liste : le catalogue d'origine reste intact.
  List<ChipsOndulees> get produitsFiltres {
    final query = normaliser(recherche.trim());
    final result = widget.catalogue.donnerChipsOndulees().where((p) {
      return (filtre == 'Tout' || p.unGout.type == filtre.toLowerCase()) &&
          normaliser('${p.nom} ${p.unGout.nom} ${p.reference}').contains(query);
    }).toList();
    if (tri == SortOrder.priceAscending) {
      result.sort((a, b) => a.prix.compareTo(b.prix));
    } else if (tri == SortOrder.priceDescending) {
      result.sort((a, b) => b.prix.compareTo(a.prix));
    }
    return result;
  }

  void reinitialiser() {
    searchController.clear();
    setState(() {
      filtre = 'Tout';
      recherche = '';
      tri = SortOrder.catalogue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final produits = produitsFiltres;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogueHero(
          onDiscover: () {
            final target = productsKey.currentContext;
            if (target != null) {
              Scrollable.ensureVisible(
                target,
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 350),
                curve: Curves.easeOut,
              );
            }
          },
        ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 28,
          runSpacing: 12,
          children: [
            _Fact(Icons.family_restroom_outlined, 'Entreprise familiale'),
            _Fact(Icons.grain_rounded, 'Fabrication en petites séries'),
            _Fact(Icons.location_on_outlined, 'Douai, Hauts-de-France'),
          ],
        ),
        const SizedBox(height: 42),
        const Divider(),
        const SizedBox(height: 28),
        Column(
          key: productsKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'LE PREMIER CATALOGUE',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 2,
                color: AppColors.muted,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 18,
              runSpacing: 10,
              children: [
                const Text(
                  'Quatre saveurs régionales.',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                LabelBadge(
                  '${widget.catalogue.donnerChipsOndulees().length} PRODUITS',
                  color: const Color(0xFFE6EBDD),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Des chips ondulées, du sel marin à la Bêtise de Cambrai.',
              style: TextStyle(color: AppColors.muted, height: 1.6),
            ),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final search = TextField(
              controller: searchController,
              onChanged: (value) => setState(() => recherche = value),
              decoration: InputDecoration(
                labelText: 'Rechercher une saveur',
                prefixIcon: const Icon(Icons.search, size: 21),
                suffixIcon: recherche.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Effacer la recherche',
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          searchController.clear();
                          setState(() => recherche = '');
                        },
                      ),
              ),
            );
            final sort = DropdownButtonFormField<SortOrder>(
              key: ValueKey(tri),
              initialValue: tri,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Trier par'),
              items: const [
                DropdownMenuItem(
                  value: SortOrder.catalogue,
                  child: Text('Ordre du catalogue'),
                ),
                DropdownMenuItem(
                  value: SortOrder.priceAscending,
                  child: Text('Prix croissant'),
                ),
                DropdownMenuItem(
                  value: SortOrder.priceDescending,
                  child: Text('Prix décroissant'),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => tri = value);
              },
            );
            return constraints.maxWidth >= 650
                ? Row(
                    children: [
                      Expanded(child: search),
                      const SizedBox(width: 16),
                      SizedBox(width: 255, child: sort),
                    ],
                  )
                : Column(children: [search, const SizedBox(height: 14), sort]);
          },
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final type in ['Tout', 'Salé', 'Sucré'])
              ChoiceChip(
                label: Text(type),
                selected: filtre == type,
                showCheckmark: false,
                selectedColor: AppColors.ink,
                labelStyle: TextStyle(
                  color: filtre == type ? Colors.white : AppColors.ink,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onSelected: (_) => setState(() => filtre = type),
              ),
            Text(
              '${produits.length} résultat${produits.length > 1 ? 's' : ''}',
              style: const TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (produits.isEmpty)
          EmptyState(
            icon: Icons.search_off,
            title: 'Aucune saveur trouvée.',
            message: 'Essaie une autre recherche ou retire les filtres.',
            actionLabel: 'Réinitialiser les filtres',
            onAction: reinitialiser,
          )
        else
          ProductGrid(
            produits: produits,
            onOpen: (produit) {
              showDialog<void>(
                context: context,
                builder: (context) => ProductDetail(produit: produit),
              );
            },
          ),
        const SizedBox(height: 30),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEEDF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 28,
            runSpacing: 16,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'La valeur du catalogue',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Un exemplaire de chaque produit, sans remise.',
                    style: TextStyle(color: AppColors.muted, fontSize: 12),
                  ),
                ],
              ),
              Text(
                euros(widget.catalogue.valeurTotale()),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Fact(this.icon, this.text);
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 18, color: AppColors.muted),
      const SizedBox(width: 9),
      Flexible(
        child: Text(
          text,
          style: const TextStyle(fontSize: 12, color: AppColors.muted),
        ),
      ),
    ],
  );
}

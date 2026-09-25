import 'package:flutter/material.dart';
import '../data/catalogue_data.dart';
import '../theme/app_theme.dart';
import '../widgets/shop_header.dart';
import 'catalogue_view.dart';
import 'story_view.dart';

/// Coquille de l'application : uniquement la navigation entre deux pages.
class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final catalogue = creerCatalogue();
  final scrollController = ScrollController();
  int page = 0;

  void changerPage(int index) {
    setState(() => page = index);
    if (scrollController.hasClients) scrollController.jumpTo(0);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.sizeOf(context).width >= 700;
    return Scaffold(
      bottomNavigationBar: desktop
          ? null
          : NavigationBar(
              selectedIndex: page,
              onDestinationSelected: changerPage,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  selectedIcon: Icon(Icons.grid_view_rounded),
                  label: 'Catalogue',
                ),
                NavigationDestination(
                  icon: Icon(Icons.storefront_outlined),
                  label: 'L’entreprise',
                ),
              ],
            ),
      body: SafeArea(
        child: Column(
          children: [
            ShopHeader(selected: page, onSelect: changerPage),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.fromLTRB(
                  desktop ? 36 : 20,
                  28,
                  desktop ? 36 : 20,
                  24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1240),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (page == 0)
                          CatalogueView(catalogue: catalogue)
                        else
                          const StoryView(),
                        const SizedBox(height: 44),
                        const Divider(),
                        const SizedBox(height: 18),
                        const Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 24,
                          runSpacing: 10,
                          children: [
                            Text(
                              'PÉTOTE · DOUAI · 2019',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.6,
                              ),
                            ),
                            Text(
                              'Étude de cas · Visuels de packaging générés',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

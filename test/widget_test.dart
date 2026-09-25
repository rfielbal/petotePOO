import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petote/data/product_styles.dart';
import 'package:petote/main.dart';
import 'package:petote/widgets/product_card.dart';

Future<void> openApp(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const PetoteApp());
  await tester.pumpAndSettle();
}

Future<void> revealAndTap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Les quatre photos locales sont présentes et décodables', (
    tester,
  ) async {
    await tester.runAsync(() async {
      for (final style in productStyles.values) {
        final bytes = await rootBundle.load(style.imageAsset);
        final codec = await ui.instantiateImageCodec(
          bytes.buffer.asUint8List(),
        );
        final frame = await codec.getNextFrame();
        expect(frame.image.width, 1024);
        expect(frame.image.height, 1536);
        frame.image.dispose();
        codec.dispose();
      }
    });
  });

  for (final width in [320.0, 390.0, 768.0, 1440.0]) {
    testWidgets('Catalogue, fiche et entreprise sans débordement à $width px', (
      tester,
    ) async {
      await openApp(tester, Size(width, 900));
      expect(find.byType(ProductCard), findsNWidgets(4));
      expect(find.text('9,50 €'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await revealAndTap(tester, find.text('Découvrir').first);
      expect(find.text('Ondulée nature'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byTooltip('Fermer la fiche'));
      await tester.pumpAndSettle();
      await revealAndTap(tester, find.text('L’entreprise').last);
      expect(find.text('Petite série.\nGrand caractère.'), findsOneWidget);
      expect(find.text('NATURE'), findsOneWidget);
      expect(find.text('500 G'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Une fenêtre desktop de faible hauteur reste utilisable', (
    tester,
  ) async {
    await openApp(tester, const Size(1280, 500));
    await revealAndTap(tester, find.text('Découvrir').first);
    await tester.ensureVisible(find.byType(Slider));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Filtres, recherche sans accents et état vide', (tester) async {
    await openApp(tester, const Size(1440, 1000));
    await revealAndTap(tester, find.widgetWithText(ChoiceChip, 'Sucré'));
    expect(find.byType(ProductCard), findsOneWidget);
    expect(find.text('Bêtise de Cambrai'), findsOneWidget);
    await revealAndTap(tester, find.widgetWithText(ChoiceChip, 'Tout'));
    await tester.enterText(find.byType(TextField), 'betise');
    await tester.pumpAndSettle();
    expect(find.byType(ProductCard), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'introuvable');
    await tester.pumpAndSettle();
    expect(find.text('Aucune saveur trouvée.'), findsOneWidget);
    await revealAndTap(tester, find.text('Réinitialiser les filtres'));
    expect(find.byType(ProductCard), findsNWidgets(4));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tri des prix dans les deux sens', (tester) async {
    await openApp(tester, const Size(1440, 1000));
    await revealAndTap(tester, find.text('Ordre du catalogue'));
    await tester.tap(find.text('Prix décroissant').last);
    await tester.pumpAndSettle();
    var cards = tester.widgetList<ProductCard>(find.byType(ProductCard));
    expect(cards.map((c) => c.produit.prix), [2.5, 2.5, 2.4, 2.1]);
    await revealAndTap(tester, find.text('Prix décroissant'));
    await tester.tap(find.text('Prix croissant').last);
    await tester.pumpAndSettle();
    cards = tester.widgetList<ProductCard>(find.byType(ProductCard));
    expect(cards.map((c) => c.produit.prix), [2.1, 2.4, 2.5, 2.5]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('La remise est une simulation, réinitialisée à la réouverture', (
    tester,
  ) async {
    await openApp(tester, const Size(390, 844));
    await revealAndTap(tester, find.text('Découvrir').first);
    expect(
      tester.widget<Text>(find.byKey(const ValueKey('promo-price'))).data,
      '2,10 €',
    );
    await tester.ensureVisible(find.byType(Slider));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Slider));
    await tester.pumpAndSettle();
    expect(
      tester.widget<Text>(find.byKey(const ValueKey('promo-price'))).data,
      '1,05 €',
    );
    await revealAndTap(tester, find.byTooltip('Fermer la fiche'));
    final nature = tester
        .widgetList<ProductCard>(find.byType(ProductCard))
        .first;
    expect(nature.produit.prix, 2.1);
    await revealAndTap(tester, find.text('Découvrir').first);
    expect(
      tester.widget<Text>(find.byKey(const ValueKey('promo-price'))).data,
      '2,10 €',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Texte agrandi sur petit écran', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await openApp(tester, const Size(320, 900));
    expect(tester.takeException(), isNull);
    await revealAndTap(tester, find.text('Découvrir').first);
    await tester.ensureVisible(find.byType(Slider));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

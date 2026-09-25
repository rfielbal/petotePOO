import 'package:flutter_test/flutter_test.dart';
import 'package:petote/data/catalogue_data.dart';
import 'package:petote/models/catalogue.dart';
import 'package:petote/models/chips_ondulees.dart';
import 'package:petote/models/gout.dart';
import 'package:petote/models/produit.dart';
import 'package:petote/models/promotable.dart';

// Un autre produit vérifie que le catalogue filtre réellement par type.
class AutreProduit extends Produit {
  AutreProduit() : super('PT-005', 'Produit de test', 500, 3);
  @override
  String describe() => nom;
}

void main() {
  test('Le catalogue reprend exactement les quatre lignes de l’annexe', () {
    final catalogue = creerCatalogue();
    final chips = catalogue.donnerChipsOndulees();
    expect(chips.map((p) => p.reference), [
      'PT-001',
      'PT-002',
      'PT-003',
      'PT-004',
    ]);
    expect(chips.map((p) => p.prix), [2.1, 2.5, 2.5, 2.4]);
    expect(chips.map((p) => p.poids), [125, 150, 150, 150]);
    expect(chips.map((p) => p.unGout.type), ['salé', 'salé', 'salé', 'sucré']);
    expect(catalogue.valeurTotale(), closeTo(9.5, 0.0001));
    expect(chips.first.calculerPrixAuKilo(), closeTo(16.8, 0.0001));
    expect(chips[1].calculerPrixAuKilo(), closeTo(16.6666667, 0.0001));
  });

  test('setPrix ignore les valeurs invalides et accepte un prix positif', () {
    final p = creerCatalogue().donnerChipsOndulees().first;
    for (final prix in [0.0, -4.0, double.nan, double.infinity]) {
      p.setPrix(prix);
      expect(p.prix, 2.1);
    }
    p.setPrix(3);
    expect(p.prix, 3);
  });

  test('Le contrat Promotable calcule une remise sans modifier le prix', () {
    final p = creerCatalogue().donnerChipsOndulees()[1];
    final Promotable promotable = p;
    expect(promotable.obtenirPrixPromo(20), 2);
    expect(promotable.obtenirPrixPromo(0), 2.5);
    expect(promotable.obtenirPrixPromo(100), 0);
    expect(p.prix, 2.5);
    for (final remise in [-1.0, 101.0, double.nan, double.infinity]) {
      expect(() => promotable.obtenirPrixPromo(remise), throwsArgumentError);
    }
  });

  test('Les objets invalides ne peuvent pas être construits', () {
    expect(
      () => ChipsOndulees('PT-001', 'Nature', 0, 2, Gout.nature()),
      throwsArgumentError,
    );
    expect(
      () => ChipsOndulees('PT-001', 'Nature', 125, 0, Gout.nature()),
      throwsArgumentError,
    );
    expect(
      () => ChipsOndulees('invalide', 'Nature', 125, 2, Gout.nature()),
      throwsArgumentError,
    );
    expect(() => Gout('Nature', 'inconnu'), throwsArgumentError);
  });

  test(
    'Catalogue vide, polymorphisme et copie indépendante de la sélection',
    () {
      final c = Catalogue();
      expect(c.valeurTotale(), 0);
      expect(c.donnerChipsOndulees(), isEmpty);
      c.ajouterProduit(AutreProduit());
      c.ajouterProduit(creerCatalogue().donnerChipsOndulees().first);
      final chips = c.donnerChipsOndulees();
      expect(chips, hasLength(1));
      chips.clear();
      expect(c.donnerChipsOndulees(), hasLength(1));
      expect(c.lesProduits, hasLength(2));
      expect(c.valeurTotale(), closeTo(5.1, 0.0001));
      expect(() => c.lesProduits.clear(), throwsUnsupportedError);
    },
  );

  test('La description contient tous les attributs demandés', () {
    final description = creerCatalogue().donnerChipsOndulees().first.describe();
    for (final valeur in [
      'PT-001',
      'Ondulée nature',
      '125',
      '2.10',
      'Sel marin',
    ]) {
      expect(description, contains(valeur));
    }
  });
}

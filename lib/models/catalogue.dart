import 'chips_ondulees.dart';
import 'produit.dart';

class Catalogue {
  final List<Produit> _lesProduits = [];

  List<Produit> get lesProduits => List.unmodifiable(_lesProduits);

  void ajouterProduit(Produit produit) => _lesProduits.add(produit);

  List<ChipsOndulees> donnerChipsOndulees() {
    final chips = <ChipsOndulees>[];
    for (final produit in _lesProduits) {
      if (produit is ChipsOndulees) chips.add(produit);
    }
    return chips;
  }

  /// Somme d'un exemplaire de chaque produit, sans notion de stock.
  double valeurTotale() {
    double total = 0;
    for (final produit in _lesProduits) {
      total += produit.prix;
    }
    return total;
  }
}

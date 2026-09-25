/// Classe abstraite de l'annexe : commune à tous les produits.
abstract class Produit {
  String _reference;
  String _nom;
  int _poids;
  double _prix;

  Produit(String reference, String nom, int poids, double prix)
    : _reference = reference,
      _nom = nom,
      _poids = poids,
      _prix = prix {
    if (!RegExp(r'^PT-\d{3}$').hasMatch(reference)) {
      throw ArgumentError('La référence doit être au format PT-xxx.');
    }
    if (nom.trim().isEmpty || poids <= 0 || !prix.isFinite || prix <= 0) {
      throw ArgumentError('Nom, poids ou prix invalide.');
    }
  }

  String get reference => _reference;
  String get nom => _nom;
  int get poids => _poids;
  double get prix => _prix;

  set reference(String valeur) {
    if (!RegExp(r'^PT-\d{3}$').hasMatch(valeur)) {
      throw ArgumentError('La référence doit être au format PT-xxx.');
    }
    _reference = valeur;
  }

  set nom(String valeur) {
    if (valeur.trim().isEmpty) throw ArgumentError('Le nom est obligatoire.');
    _nom = valeur;
  }

  set poids(int valeur) {
    if (valeur <= 0) throw ArgumentError('Le poids doit être positif.');
    _poids = valeur;
  }

  set prix(double valeur) => setPrix(valeur);

  /// Comme demandé dans l'annexe, une valeur invalide est ignorée.
  void setPrix(double prix) {
    if (prix.isFinite && prix > 0) _prix = prix;
  }

  double calculerPrixAuKilo() => _prix * 1000 / _poids;

  String describe();
}

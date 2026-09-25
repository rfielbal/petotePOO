class Gout {
  String _nom;
  String _type;

  Gout(String nom, String type) : _nom = nom, _type = type {
    this.nom = nom;
    this.type = type;
  }

  String get nom => _nom;
  String get type => _type;

  set nom(String valeur) {
    if (valeur.trim().isEmpty) throw ArgumentError('Le goût est obligatoire.');
    _nom = valeur;
  }

  set type(String valeur) {
    if (valeur != 'salé' && valeur != 'sucré') {
      throw ArgumentError('Le type doit être salé ou sucré.');
    }
    _type = valeur;
  }

  static Gout nature() => Gout('Sel marin', 'salé');
  static Gout andouilletteMaroilles() =>
      Gout('Andouillette & Maroilles', 'salé');

  // Orthographe corrigée ; le type salé reste celui du tableau de l'annexe.
  static Gout gaufreLilloise() => Gout('Gaufre Lilloise', 'salé');
  static Gout betiseCambrai() => Gout('Bêtise de Cambrai', 'sucré');
}

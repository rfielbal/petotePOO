import '../models/catalogue.dart';
import '../models/chips_ondulees.dart';
import '../models/gout.dart';

/// Unique source des données métier : tableau de l'annexe 1, page 1.
/// Aucune API, base de données ni sauvegarde locale.
Catalogue creerCatalogue() {
  return Catalogue()
    ..ajouterProduit(
      ChipsOndulees('PT-001', 'Ondulée nature', 125, 2.10, Gout.nature()),
    )
    ..ajouterProduit(
      ChipsOndulees(
        'PT-002',
        'Ondulée Andouillette & Maroilles',
        150,
        2.50,
        Gout.andouilletteMaroilles(),
      ),
    )
    ..ajouterProduit(
      ChipsOndulees(
        'PT-003',
        'Ondulée gaufre Lilloise',
        150,
        2.50,
        Gout.gaufreLilloise(),
      ),
    )
    ..ajouterProduit(
      ChipsOndulees(
        'PT-004',
        'Ondulée Bêtise de Cambrai',
        150,
        2.40,
        Gout.betiseCambrai(),
      ),
    );
}

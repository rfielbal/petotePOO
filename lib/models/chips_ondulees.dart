import 'gout.dart';
import 'produit.dart';
import 'promotable.dart';

class ChipsOndulees extends Produit implements Promotable {
  Gout _unGout;

  ChipsOndulees(super.reference, super.nom, super.poids, super.prix, Gout gout)
    : _unGout = gout;

  // Attribut privé et accesseurs conservés pour correspondre à l'annexe.
  // ignore: unnecessary_getters_setters
  Gout get unGout => _unGout;
  set unGout(Gout valeur) => _unGout = valeur;

  @override
  String describe() =>
      '$reference · $nom · $poids g · ${prix.toStringAsFixed(2)} € · ${_unGout.nom}';

  @override
  double obtenirPrixPromo(double remise) {
    if (!remise.isFinite || remise < 0 || remise > 100) {
      throw ArgumentError('La remise doit être comprise entre 0 et 100 %.');
    }
    return prix * (1 - remise / 100);
  }
}

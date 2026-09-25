String euros(double valeur) =>
    '${valeur.toStringAsFixed(2).replaceAll('.', ',')} €';

/// Recherche tolérante aux accents, sans package supplémentaire.
String normaliser(String texte) {
  var resultat = texte.toLowerCase();
  const accents = {
    'é': 'e',
    'è': 'e',
    'ê': 'e',
    'ë': 'e',
    'à': 'a',
    'â': 'a',
    'î': 'i',
    'ï': 'i',
    'ô': 'o',
    'ù': 'u',
    'û': 'u',
    'ç': 'c',
  };
  accents.forEach(
    (accent, lettre) => resultat = resultat.replaceAll(accent, lettre),
  );
  return resultat;
}

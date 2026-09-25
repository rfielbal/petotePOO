# Les packagings Pétote

Quatre visuels photoréalistes ont été générés avec **ImageGen intégré**, puis copiés dans `assets/images/`. L'application les affiche avec `Image.asset`, sans connexion à un service externe.

| Référence | Fichier | Saveur | Poids |
| --- | --- | --- | --- |
| PT-001 | chips_nature.png | Nature / Sel marin | 125 g |
| PT-002 | chips_maroilles.png | Andouillette & Maroilles | 150 g |
| PT-003 | chips_gaufre.png | Gaufre lilloise | 150 g |
| PT-004 | chips_cambrai.png | Bêtise de Cambrai | 150 g |

Format : PNG 1024 × 1536 px, portrait, fond ivoire opaque. Le même style de sachet mat, de typographie et d'éclairage est utilisé pour les quatre saveurs. Les visuels sont des créations graphiques pour l'étude de cas, et non des photographies de produits effectivement commercialisés.

Aucun prix, label, ingrédient, certification, stock ou information nutritionnelle n'a été ajouté sur les sachets. Les saveurs et poids viennent de l'annexe 1. Les premiers essais de transparence non homogènes ont été remplacés par un fond studio ivoire ; seuls les quatre visuels finaux sont inclus dans le dépôt.

## Modifier une image

Remplacer le fichier concerné dans `assets/images/` ou modifier son chemin dans `lib/data/product_styles.dart`. Le dossier est déjà déclaré dans `pubspec.yaml`. Le widget commun est `lib/widgets/product_visual.dart` et conserve les proportions avec `BoxFit.contain`.

## Prompts originaux

Consignes exactes conservées pour rendre les créations reproductibles. La première image a servi de référence pour les trois variantes.

### Sachet nature

Use case: product-mockup. Create a single photorealistic studio product photograph for a French student Flutter catalog. Brand Pétote, a family company founded in Douai in 2019 making small-batch RIDGED potato chips. One premium but believable upright inflated potato-chip bag, sealed crimped edges top and bottom, subtle realistic creases in matte flexible packaging. Shape: tall rectangular pillow pouch, portrait aspect 2:3. Design system for a series of four flavors: warm ivory upper quarter, mustard yellow #CCA844 main lower section, generous confident dark forest green typography, thin elegant engraved drawing of ridged potato chips printed on the bag. Exact printed text ONLY: large "pétote.", smaller "CHIPS ONDULÉES", large flavor "Nature", subline "Sel marin", small "125 g". No other text or claims. Spelling and accents must be perfect. Bag centered, complete, mostly frontal with a tiny three-quarter turn, filling about 78% of frame height with generous transparent margin, identical studio perspective suitable for all four series photos. Two actual golden oval potato chips with pronounced parallel ridges in front near bottom right, not covering the flavor or weight. Soft directional studio lighting from top left, premium editorial grocery product photography, crisp tactile paper-like matte plastic, realistic soft shadows. GENUINELY TRANSPARENT BACKGROUND with alpha, no floor, no scene, no checkerboard pixels, no colored backdrop. 1024x1536 portrait. No stickers, no certifications, no price, no barcode, no nutrition panel, no fake regional origin guarantee, no hands. Output one single image, not a grid.

### Variante maroilles

Use case: product-mockup. Input image is the reference for the Pétote packaging series. Generate a NEW single matching photorealistic product photo of the Andouillette & Maroilles flavor. Keep exactly the same bag proportions, upright frontal pose, matte material, top ivory panel, typography, crimped sealed edges, printed engraved ridged-chip drawing, lighting and photo framing as the reference. Change only the lower bag color to terracotta #A45036, flavor name and weight. Printed text ONLY: large brand "pétote.", "CHIPS ONDULÉES", flavor "Andouillette & Maroilles", small "150 g". Remove the Nature and Sel marin text entirely. Set the flavor text elegantly on three balanced lines as necessary to fit. Accurate French accents and spelling. These are RIDGED POTATO CHIPS with Andouillette & Maroilles flavor, classified salé in the supplied school catalog; do not turn them into actual waffles or candy. No additional flavors, ingredients, certifications, guarantees, prices, locations, barcode or nutrition claims. Two real golden ridged potato chips near lower right, below the main printed flavor. The full product must fit inside the frame with 8% margin. GENUINE transparent background with alpha, background pixels fully transparent, no dark halo or dark vignette, no floor or backdrop, no checkerboard printed. Portrait 1024x1536. Single isolated bag, not grid.

### Variante gaufre

Use case: product-mockup. Input image is the reference for the Pétote packaging series. Generate a NEW single matching photorealistic product photo of the Gaufre lilloise flavor. Keep exactly the same bag proportions, upright frontal pose, matte material, top ivory panel, typography, crimped sealed edges, printed engraved ridged-chip drawing, lighting and photo framing as the reference. Change only the lower bag color to sage green #55764D, flavor name and weight. Printed text ONLY: large brand "pétote.", "CHIPS ONDULÉES", flavor "Gaufre lilloise", small "150 g". Remove the Nature and Sel marin text entirely. Set the flavor text elegantly on two balanced lines as necessary to fit. Accurate French accents and spelling. These are RIDGED POTATO CHIPS with Gaufre lilloise flavor, classified salé in the supplied school catalog; do not turn them into actual waffles or candy. No additional flavors, ingredients, certifications, guarantees, prices, locations, barcode or nutrition claims. Two real golden ridged potato chips near lower right, below the main printed flavor. The full product must fit inside the frame with 8% margin. GENUINE transparent background with alpha, background pixels fully transparent, no dark halo or dark vignette, no floor or backdrop, no checkerboard printed. Portrait 1024x1536. Single isolated bag, not grid.

### Variante cambrai

Use case: product-mockup. Input image is the reference for the Pétote packaging series. Generate a NEW single matching photorealistic product photo of the Bêtise de Cambrai flavor. Keep exactly the same bag proportions, upright frontal pose, matte material, top ivory panel, typography, crimped sealed edges, printed engraved ridged-chip drawing, lighting and photo framing as the reference. Change only the lower bag color to muted teal blue #648D8D, flavor name and weight. Printed text ONLY: large brand "pétote.", "CHIPS ONDULÉES", flavor "Bêtise de Cambrai", small "150 g". Remove the Nature and Sel marin text entirely. Set the flavor text elegantly on two balanced lines as necessary to fit. Accurate French accents and spelling. These are RIDGED POTATO CHIPS with Bêtise de Cambrai flavor, classified sucré in the supplied school catalog; do not turn them into actual waffles or candy. No additional flavors, ingredients, certifications, guarantees, prices, locations, barcode or nutrition claims. Two real golden ridged potato chips near lower right, below the main printed flavor. The full product must fit inside the frame with 8% margin. GENUINE transparent background with alpha, background pixels fully transparent, no dark halo or dark vignette, no floor or backdrop, no checkerboard printed. Portrait 1024x1536. Single isolated bag, not grid.

### Fond studio final — appliqué aux quatre images

Edit this product photograph. ONLY replace the entire surrounding background (including any grey checkerboard, dark vignette or transparency) with a smooth flat uniform warm ivory studio backdrop hex #F4F0E7. The result MUST be an opaque RGB photograph with an ivory background, NOT transparent, NO checkerboard pattern at all. Add only a soft natural subtle contact shadow below the bag and real chips. Preserve the exact packaging, typography, all text, spelling, flavor, weight, colors, ridged chips, lighting, sharpness and front-facing composition of the input unchanged. Do not redraw text or add text. Product remains entirely in frame, centered, with clean ivory margins of 8% at top and bottom, no cropping. Same portrait 1024x1536. Professional clean e-commerce photo, no gradients, no border.

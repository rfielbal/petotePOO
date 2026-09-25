import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ShopHeader extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const ShopHeader({super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.sizeOf(context).width >= 700;
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: desktop ? 36 : 20,
        vertical: 14,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Row(
            children: [
              SizedBox(
                width: 116,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Semantics(
                    header: true,
                    child: const Text(
                      'pétote.',
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                ),
              ),
              if (desktop) ...[
                const SizedBox(width: 24),
                const Expanded(
                  child: Text(
                    'CHIPS ONDULÉES\nHAUTS-DE-FRANCE',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.muted,
                      height: 1.6,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
                for (var i = 0; i < 2; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: selected == i
                            ? AppColors.ink
                            : Colors.transparent,
                        foregroundColor: selected == i
                            ? AppColors.cream
                            : AppColors.ink,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 18,
                        ),
                      ),
                      onPressed: () => onSelect(i),
                      child: Text(['Le catalogue', 'L’entreprise'][i]),
                    ),
                  ),
              ] else ...[
                const SizedBox(width: 20),
                const Expanded(
                  child: Text(
                    'DOUAI\nDEPUIS 2019',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.muted,
                      height: 1.6,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

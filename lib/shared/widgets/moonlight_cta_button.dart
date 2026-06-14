import 'package:flutter/material.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/core/theme/app_text_styles.dart' show AppTextStyles;

class MoonlightCtaButton extends StatelessWidget {
  const MoonlightCtaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: loading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.moonlightGold,
              foregroundColor: const Color(0xFF283044),
              disabledBackgroundColor: AppColors.moonlightGold.withValues(alpha: 0.5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF283044),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(label, style: AppTextStyles.headlineMd.copyWith(
                        color: const Color(0xFF283044),
                        fontSize: 16,
                      )),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class MoonlightCtaBar extends StatelessWidget {
  const MoonlightCtaBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(color: AppColors.glassBorder),
        ),
      ),
      child: MoonlightCtaButton(
        label: label,
        onPressed: onPressed,
        icon: icon,
        loading: loading,
      ),
    );
  }
}

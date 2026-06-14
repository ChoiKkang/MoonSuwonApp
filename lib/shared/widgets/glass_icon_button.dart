import 'package:flutter/material.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;

class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withValues(alpha: 0.5),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Icon(
          icon,
          size: 20,
          color: color ?? AppColors.onSurface,
        ),
      ),
    );
  }
}

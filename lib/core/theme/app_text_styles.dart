import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get headlineLg => GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: AppColors.onSurface,
      );

  static TextStyle get headlineMd => GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: AppColors.onSurface,
      );

  static TextStyle get bodyLg => GoogleFonts.manrope(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: AppColors.onSurface,
      );

  static TextStyle get bodyMd => GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: AppColors.onSurface,
      );

  static TextStyle get labelMd => GoogleFonts.hankenGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05 * 14,
        color: AppColors.onSurface,
      );

  static TextStyle get labelSm => GoogleFonts.hankenGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      );
}

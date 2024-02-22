import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const fontSize10GreyW500 = TextStyle(
    color: AppColors.blackColor,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static const blackFontSize10W400 = TextStyle(
    color: AppColors.textColor635976,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static const blackFontSize13W700 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    fontFamily: 'Inter',
    color: Color(0xFF635976),
  );
}
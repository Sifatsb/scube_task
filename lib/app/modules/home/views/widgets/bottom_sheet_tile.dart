import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task/app/data/constants/app_colors.dart';
import 'package:scube_task/app/data/constants/app_text_style.dart';

class BottomSheetTile extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final Color? borderColor;
  final bool hasMultipleData;
  final Widget? listview;
  final double? width;
  final double? height;
  final double? boxHeight;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;

  const BottomSheetTile({
    super.key,
    this.title,
    this.value,
    this.color,
    this.hasMultipleData = false,
    this.listview,
    this.width,
    this.height,
    this.boxHeight,
    this.titleTextStyle,
    this.valueTextStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxHeight ?? Get.height * 0.04,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColors.ofWhiteColor,
        ),
        color: color,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: width ?? Get.width * 0.35,
            child: Text(
              title ?? "",
              style: titleTextStyle ?? AppTextStyle.fontSize10GreyW500,
            ),
          ),
          VerticalDivider(
            color: AppColors.bottomSheetDividerColor,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Text(
              value ?? "",
              style: valueTextStyle ?? AppTextStyle.blackFontSize10W400,
            ),
          ),
        ],
      ),
    );
  }
}

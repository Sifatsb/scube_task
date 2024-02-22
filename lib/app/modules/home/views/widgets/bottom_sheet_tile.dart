import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task/app/data/constants/app_colors.dart';
import 'package:scube_task/app/data/constants/app_text_style.dart';

class BottomSheetTile extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final bool hasMultipleData;
  final Widget? listview;
  final double? width;
  final double? height;

  const BottomSheetTile({
    super.key,
    this.title,
    this.value,
    this.color,
    this.hasMultipleData = false,
    this.listview,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.04,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.ofWhiteColor,
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
              style: AppTextStyle.fontSize10GreyW500,
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
              style: AppTextStyle.blackFontSize10W400,
            ),
          ),
        ],
      ),
    );
  }
}

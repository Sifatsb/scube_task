import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_task/app/data/constants/app_colors.dart';
import 'package:scube_task/app/data/constants/app_text_style.dart';
import 'package:scube_task/app/utilities/common_widgets/text_fields/custom_text_form_field.dart';

class CustomTextFieldWithTile extends StatelessWidget {
  final String? title;
  final String? value;
  final String? hintTex;
  final Color? color;
  final TextEditingController controller;
  final TextEditingController? dateController;
  final bool readOnly;
  final Function()? iconOnTap;
  final TextInputType? keyboardType;


  const CustomTextFieldWithTile(
      {super.key,
        this.title,
        this.value,
        this.color,
        required this.controller,
        this.hintTex,
        this.readOnly = false,
      this.iconOnTap,
        this.dateController,
        this.keyboardType,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 141,
            child: Text(
              title ?? "",
              style: AppTextStyle.fontSize10GreyW500,
            ),
          ),
          VerticalDivider(
            color: AppColors.bottomSheetDividerColor,
            thickness: 1,
          ),
          // Text('data'),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              height: 22,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.5),
                  color: Colors.white,
                  border:
                  Border.all(color: AppColors.appColorB5C1CB, width: 0.5)),
              child: readOnly ? CustomTextFormField(
                iconOnTap: iconOnTap,
                readOnly: true,
                controller: dateController,
                enableBorderActive: true,
                focusBorderActive: true,
                hintText: hintTex ?? "Select Date",
                fillColor: Colors.white,
                hintTextStyle: AppTextStyle.hintTextStyle,
                suffixIcon: const Icon(Icons.date_range_outlined, color: Colors.black, size: 16,),
              ) : TextField(
                controller: controller,
                readOnly: readOnly,
                style: AppTextStyle.font10Weight400,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, -6, 10, 14),
                  hintText: hintTex ?? "Input...",
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
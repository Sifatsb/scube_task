import 'package:flutter/material.dart';
import 'package:scube_task/app/data/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController? controller;
  final double? height;
  final double? width;
  final String? tile;

  const CustomTextField({super.key, this.controller, this.height, this.width, this.tile,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text('${tile ?? 'Tile'} : '),
          Expanded(
            child: Container(
              height: height ?? 45,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // Adjust padding as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                // Radius of the border
                border: Border.all(
                  color: const Color(0xFFEAE7F0), // Border color
                  width: 1, // Border width
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      controller: controller,
                      decoration: const InputDecoration(
                        border:
                        InputBorder.none,
                        hintText: "Edit...",
                        hintStyle: TextStyle(
                            color: AppColors.hintTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

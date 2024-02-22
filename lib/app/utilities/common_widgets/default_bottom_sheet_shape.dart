import 'package:flutter/material.dart';

ShapeBorder defaultBottomSheetShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(
        8,
      ),
      topRight: Radius.circular(
        8,
      ),
    ),
  );
}

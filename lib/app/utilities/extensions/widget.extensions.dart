import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


extension WidgetExtension on num {
  Widget get horizontalSpacing => SizedBox(width: toDouble());

  Widget get verticalSpacing => SizedBox(height: toDouble());

  BorderRadius get circularRadius => BorderRadius.circular(toDouble());
}

extension DateExtension on DateTime {
  // ignore: non_constant_identifier_names
  String get dd_mm_yyyy => DateFormat('dd/MM/yyyy').format(this).toString();
  // ignore: non_constant_identifier_names
  String get yyyy_mm_dd => DateFormat('yyyy-MM-dd').format(this).toString();
}
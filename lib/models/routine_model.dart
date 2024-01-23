import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';

class Routine{
  late int? day, from, to, sem;
  late String? type, code, prof;

  Routine({
    this.day,
    this.from,
    this.to,
    this.sem,
    this.type,
    this.code,
    this.prof
  });
}

class RoutineInfo {
  final String? svgSrc, title, prof, room;
  final int? percentage, from, to;
  final Color? color;

  RoutineInfo({
    this.svgSrc,
    this.title,
    this.from,
    this.to,
    this.prof,
    this.room,
    this.percentage,
    this.color,
  });
}

final List<String> svgLogos = [
  "assets/icons/Documents.svg",
  "assets/icons/google_drive.svg",
  "assets/icons/one_drive.svg",
  "assets/icons/drop_box.svg",
];

final List<Color> cardColors = [
  AppTheme.primaryColor, Color(0xFFFFA113), Color(0xFFA4CDFF), Color(0xFF007EE5),
];
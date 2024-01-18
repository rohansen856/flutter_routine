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
  final String? svgSrc, title, timings, prof, room;
  final int? percentage;
  final Color? color;

  RoutineInfo({
    this.svgSrc,
    this.title,
    this.timings,
    this.prof,
    this.room,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  RoutineInfo(
    title: "Documents",
    prof: "1328",
    svgSrc: "assets/icons/Documents.svg",
    timings: "1.9GB",
    color: AppTheme.primaryColor,
    percentage: 35,
  ),
  RoutineInfo(
    title: "Google Drive",
    prof: "1328",
    svgSrc: "assets/icons/google_drive.svg",
    timings: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  RoutineInfo(
    title: "One Drive",
    prof: "1328",
    svgSrc: "assets/icons/one_drive.svg",
    timings: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  RoutineInfo(
    title: "Documents",
    prof: "5328",
    svgSrc: "assets/icons/drop_box.svg",
    timings: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];

final List<String> svgLogos = [
  "assets/icons/Documents.svg",
  "assets/icons/google_drive.svg",
  "assets/icons/one_drive.svg",
  "assets/icons/drop_box.svg",
];

final List<Color> cardColors = [
  AppTheme.primaryColor, Color(0xFFFFA113), Color(0xFFA4CDFF), Color(0xFF007EE5),
];
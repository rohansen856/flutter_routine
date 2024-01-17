import 'package:admin/theme/theme_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionData,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: FitnessAppTheme.defaultPadding),
                Text(
                  "16",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("of Sem 2")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionData = [
  PieChartSectionData(
    color: FitnessAppTheme.primaryColor,
    value: 3,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 4,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 4,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 2,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: FitnessAppTheme.primaryColor.withOpacity(0.1),
    value: 4,
    showTitle: false,
    radius: 13,
  ),
];

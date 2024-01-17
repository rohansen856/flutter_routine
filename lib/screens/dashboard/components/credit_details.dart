import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import 'credit_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(FitnessAppTheme.defaultPadding),
      decoration: BoxDecoration(
        color: FitnessAppTheme.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Credit Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: FitnessAppTheme.defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Mathematics 2",
            amountOfFiles: "4 cred.",
            numOfFiles: "BG+NKM",
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Physics 2",
            amountOfFiles: "4 cred.",
            numOfFiles: "BG+NKM",
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Engineering Graphics",
            amountOfFiles: "4 cred.",
            numOfFiles: "BG+NKM",
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Humanities",
            amountOfFiles: "2 cred.",
            numOfFiles: "MA",
          ),
        ],
      ),
    );
  }
}
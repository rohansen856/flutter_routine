import 'package:admin/database/credits_database.dart';
import 'package:admin/database/settings_database.dart';
import 'package:admin/models/credits_model.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import 'credit_info_card.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<StorageDetails> createState() => _StorageDetails();
}

class _StorageDetails extends State<StorageDetails> {
    List<CreditsInfo> allData = [];
    int totalCredits = 0;


  Future<void> func() async{
    var dat = await SettingsDatabase().getInitialUser();
    List<Map<String, dynamic>> data = await CreditsDatabase().getCredits(dat.branch.toString().toUpperCase(), dat.sem??0,);

    List<CreditsInfo> info = [];
    print(data);
    for (var i = 0; i < data.length; i++) {
      info.add(CreditsInfo(
        sem: data[i]['sem'],
        branch: data[i]['branch'].toString(),
        subject: data[i]['subject_name'].toString(),
        credits: data[i]['credits'],
        prof: data[i]['prof']
      ));
    }
    setState(() {
      info.sort((a,b)=>b.credits!.compareTo(a.credits!));
      allData = info.length==0?[]:info;
      totalCredits =  info.map<int>((subject) => subject.credits??0).reduce((value, element) => value + element);
      print(allData);
    });
  }

  @override
  initState(){
    // TODO: implement initState
    func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.defaultPadding),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor,
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
          SizedBox(height: AppTheme.defaultPadding),
          Chart(totalCredits: totalCredits,),
          allData.length>0?
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: allData[0].subject.toString(),
            amountOfFiles: "${allData[0].credits.toString()} cred.",
            numOfFiles: allData[0].prof.toString(),
          ):SizedBox(),
          allData.length>1?
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: allData[1].subject.toString(),
            amountOfFiles: "${allData[1].credits.toString()} cred.",
            numOfFiles: allData[1].prof.toString(),
          ):SizedBox(),
          allData.length>2?
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: allData[2].subject.toString(),
            amountOfFiles: "${allData[2].credits.toString()} cred.",
            numOfFiles: allData[2].prof.toString(),
          ):SizedBox(),
          allData.length>3?
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: allData[3].subject.toString(),
            amountOfFiles: "${allData[3].credits.toString()} cred.",
            numOfFiles: allData[3].prof.toString(),
          ):SizedBox(),
          allData.length>4?
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: allData[4].subject.toString(),
            amountOfFiles: "${allData[4].credits.toString()} cred.",
            numOfFiles: allData[4].prof.toString(),
          ):SizedBox(),
          allData.length>5?
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: allData[5].subject.toString(),
            amountOfFiles: "${allData[5].credits.toString()} cred.",
            numOfFiles: allData[5].prof.toString(),
          ):SizedBox(),
        ],
      ),
    );
  }
}
import 'package:admin/database/routine_database.dart';
import 'package:admin/models/routine_model.dart';
import 'package:admin/responsive.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'file_info_card.dart';

class MyFiles extends StatefulWidget {

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Classes",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: FitnessAppTheme.defaultPadding * 1.5,
                  vertical:
                      FitnessAppTheme.defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),
        SizedBox(height: FitnessAppTheme.defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  List allData = [];

  Future<void> func() async{
    await RoutineDatabase().getRoutine(1, 2);
    List<Map<String, dynamic>> data = await RoutineDatabase().getRoutine(DateTime.now().weekday, 2);

    List<RoutineInfo> info = [];
    print(data.length);
    for (var i = 0; i < data.length; i++) {
      info.add(RoutineInfo(
        title: "${data[i]['code'].toString()} (${data[i]['type'].toString()})",
        prof: data[i]['prof'].toString(),
        svgSrc: svgLogos[i],
        timings: "${(data[i]['from']/100).round()}:00 - ${(data[i]['to']/100).round()}:00",
        color: cardColors[i],
        percentage: 70,
      ));
    }
    setState(() {
      allData = info;
    });
    print(allData.length);
}
  @override
  initState(){
    // TODO: implement initState
    func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return allData.length<=0? CircularProgressIndicator(): GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: allData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: FitnessAppTheme.defaultPadding,
        mainAxisSpacing: FitnessAppTheme.defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: allData[index]),
    );
  }
}

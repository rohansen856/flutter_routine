import 'package:admin/database/routine_database.dart';
import 'package:admin/database/settings_database.dart';
import 'package:admin/models/routine_model.dart';
import 'package:admin/responsive.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'routine_info_card.dart';

class MyFiles extends StatefulWidget {

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

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
                  horizontal: AppTheme.defaultPadding * 1.5,
                  vertical:
                      AppTheme.defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.calendar_today_rounded),
              label: Text(weekdays[DateTime.now().weekday-1]),
            ),
          ],
        ),
        SizedBox(height: AppTheme.defaultPadding),
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
    var dat = await SettingsDatabase().getInitialUser();
    print(dat.branch.toString().toUpperCase());
    List<Map<String, dynamic>> data = await RoutineDatabase().getRoutine(DateTime.now().weekday, dat.branch.toString().toUpperCase(), dat.sem??0);

    List<RoutineInfo> info = [];
    for (var i = 0; i < data.length; i++) {
      info.add(RoutineInfo(
        title: "${data[i]['code'].toString()} (${data[i]['type'].toString()})",
        prof: data[i]['prof'].toString(),
        room: data[i]['room'].toString(),
        svgSrc: svgLogos[i],
        timings: "${(data[i]['from']/100).round()}:00 - ${(data[i]['to']/100).round()}:00",
        color: cardColors[i],
        percentage: 100,
      ));
    }
    setState(() {
      allData = info.length==0?[null]:info;
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
    if(allData.length<=0)
    return Container(
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color:  AppTheme.secondaryColor,
      ),
      child: Center(child: CircularProgressIndicator()),
    );
    else 
    return allData[0]==null
    ? Container(
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color:  AppTheme.secondaryColor,
      ),
      child: Center(child: Text('NO CLASSES TODAY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,),)),
    )
    : GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: allData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: AppTheme.defaultPadding,
        mainAxisSpacing: AppTheme.defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: allData[index]),
    );
  }
}

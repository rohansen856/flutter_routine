import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/widgets/mess_list_data.dart';
import 'package:admin/screens/dashboard/widgets/routine_fields.dart';
import 'package:admin/screens/dashboard/widgets/credit_details.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
    const DashboardScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        MyFiles(),
                        SizedBox(height: AppTheme.defaultPadding),
                        // RecentFiles(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mess menu",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            MealsListView(),
                          ],
                        ),
                        if (Responsive.isMobile(context))
                          SizedBox(height: AppTheme.defaultPadding),
                        if (Responsive.isMobile(context)) StorageDetails(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: AppTheme.defaultPadding),
                  // On Mobile means if the screen is less than 850 we don't want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: StorageDetails(),
                    ),
                ],
              ),
              SizedBox(height: 45,),
            ],
          ),
        ),
      );
  }
}

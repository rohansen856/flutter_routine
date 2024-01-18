import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/mess_list_data.dart';
import 'package:admin/screens/dashboard/components/routine_fields.dart';
import 'package:admin/screens/dashboard/components/credit_details.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'components/header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
            Header(),
            SizedBox(height: AppTheme.defaultPadding),
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
            )
          ],
        ),
      ),
    );
  }
}

import 'package:admin/animation/text_load_animation.dart';
import 'package:admin/database/settings_database.dart';
import 'package:admin/main.dart';
import 'package:admin/models/settings_model.dart';
import 'package:admin/screens/auth/auth_screen.dart';
import 'package:admin/screens/settings/widgets/settings_list.dart';
import 'package:admin/screens/settings/widgets/settings_section.dart';
import 'package:admin/screens/settings/widgets/settings_tile.dart';
import 'package:admin/screens/settings/utils/platform_utils.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  bool useCustomTheme = false;
  var session = supabase.auth.currentSession;

  late SettingsInfo? userData = null;
  String? branch = null;
  String? semester = null;

  Future<void> func() async{
    late SettingsInfo? data;
    try{
      data = await SettingsDatabase().getUser();
    }catch(err){
      data = null;
    }finally{
      setState(() {
        userData = data;
        branch = userData!.branch != null ? userData!.branch.toString():'';
        semester = userData!.sem != null ? userData!.sem.toString():'';
      });
      print({branch,semester});
    }
  }

  @override
  initState(){
    // TODO: implement initState
    func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(height: 45),
      body: SettingsList(
        platform: selectedPlatform,
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.cloud_outlined),
                title: Text('Environment'),
                value: Text('Production'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    useCustomTheme = value;
                  });
                },
                initialValue: useCustomTheme,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.phone),
                title: Text('Phone number'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.mail),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email',), 
                    userData!=null
                    ?Text(userData?.email??'', style: TextStyle(color: AppTheme.deactivatedText),)
                    :TextLoadingAnimation()
                  ],
                ),
                enabled: session != null,
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.logout),
                title: session != null? Text('Sign out'):Text('Sign in'),
                onPressed: (_){
                  if(session==null)
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                  else showAlertDialog(context);
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('User Info'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                onPressed: (_){branchSelectDialogue(context);},
                leading: Icon(Icons.book),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Branch',), 
                    branch!=null
                    ?Text(branch??'', style: TextStyle(color: AppTheme.deactivatedText),)
                    :TextLoadingAnimation()
                  ],
                ),
                enabled: session != null,
              ),
              SettingsTile.navigation(
                onPressed: (_){semSelectDialogue(context);},
                leading: Icon(Icons.school),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Semester',), 
                    semester!=null 
                    ?Text(semester??'', style: TextStyle(color: AppTheme.deactivatedText),)
                    :TextLoadingAnimation()
                  ],
                ),
                enabled: session != null,
                description: Text('Set This Data for Homescreen'),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: Icon(Icons.lock),
                title: Text('Change password'),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: Icon(Icons.notifications_active),
                title: Text('Enable notifications'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Misc'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.description),
                title: Text('Terms of Service'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.collections_bookmark),
                title: Text('Open source license'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out?'),
          content: Text('Do you really want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Cancel')
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                if(session!=null){
                  supabase.auth.signOut();
                  SettingsDatabase().clearData();
                  setState(() {
                    userData = null;
                    session = null;
                    branch = '';
                    semester = '';
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void branchSelectDialogue(BuildContext context) {
    List<String> branches = ['CS', 'EC', 'ME', 'SM', 'DS'];
    List<Widget> widList = [];

    branches.forEach((el)=>widList.add(
        TextButton(
              onPressed: () async{
                // Close the dialog
                bool res = await SettingsDatabase().writeData(SettingsArgs.branch, el);
                if(res){
                  setState(() {
                    branch = el;
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text(el),
            ),
      )
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: widList,
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  void semSelectDialogue(BuildContext context) {
    List<int> sems = [1,2,3,4,5,6,7,8];
    List<Widget> widList = [];

    sems.forEach((el)=>widList.add(
        TextButton(
              onPressed: () async{
                // Close the dialog
                bool res = await SettingsDatabase().writeData(SettingsArgs.sem, el.toString());
                if(res){
                  setState(() {
                    semester = el.toString();
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text(el.toString()),
            ),
      )
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: widList,
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
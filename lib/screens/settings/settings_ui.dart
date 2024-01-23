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
import 'package:url_launcher/url_launcher.dart';

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
  var session = supabase.auth.currentSession;

  bool isLoading = false;

  late SettingsInfo? userData = null;
  bool? isProfileVisible = null;
  String? branch = null;
  String? semester = null;
  int? roll = null;

  Future<void> func() async{
    setState(() {
      isLoading = true;
    });
    late SettingsInfo? data;
    try{
      data = await SettingsDatabase().getUser();
    }catch(err){
      data = null;
    }finally{
      setState(() {
        isLoading = false;
        userData = data;
        branch = userData!.branch != null ? userData!.branch.toString():'';
        semester = userData!.sem != null ? userData!.sem.toString():'';
        roll = userData!.roll != null ? userData!.roll:0;
        isProfileVisible = userData!.isProfileVisible != null ? userData!.isProfileVisible:false;
      });
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
            ],
          ),
          SettingsSection(
            title: Text('Account'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.phone),
                title: Text('Phone number'),
                enabled: false,
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.mail),
                title: Text('Email',),
                trailing: isLoading
                  ?TextLoadingAnimation()
                  :Text(userData?.email??'', style: TextStyle(color: AppTheme.deactivatedText),),
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
                  else signoutConfirmDialog(context);
                },
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  changeVisibility(value);
                },
                initialValue: isProfileVisible,
                leading: Icon(isProfileVisible!=null ? isProfileVisible!? Icons.visibility:Icons.visibility_off:Icons.visibility),
                title: Text('Profile visibility'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('Academic Info'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                // onPressed: (_){/*branchSelectDialogue(context);*/},
                leading: Icon(Icons.school),
                title: Text('Branch',),
                trailing: isLoading
                  ?TextLoadingAnimation()
                  :Text(branch??'', style: TextStyle(color: AppTheme.deactivatedText),),
                enabled: session != null,
              ),
              SettingsTile.navigation(
                // onPressed: (_){/*semSelectDialogue(context);*/},
                leading: Icon(Icons.book),
                title: Text('Semester',), 
                trailing: isLoading
                  ?TextLoadingAnimation()
                  :Text(semester??'', style: TextStyle(color: AppTheme.deactivatedText),),
                enabled: session != null,
              ),
              SettingsTile.navigation(
                // onPressed: (_){/*semSelectDialogue(context);*/},
                leading: Icon(Icons.numbers),
                title: Text('Roll No',), 
                trailing: isLoading
                  ?TextLoadingAnimation()
                  :Text(roll.toString(), style: TextStyle(color: AppTheme.deactivatedText),),
                enabled: session != null,
                description: Text('Your verified student data'),
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
                onPressed: (_){
                  _launchUrl("https://github.com/rohansen856");
                },
                leading: Icon(Icons.collections_bookmark),
                title: Text('Meet The Developer'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String uri) async {
    final _url = Uri.parse(uri);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void signoutConfirmDialog(BuildContext context) {
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
                Navigator.of(context).pop();
                if(session!=null){
                  try {supabase.auth.signOut();}
                  finally {
                    SettingsDatabase().clearData();
                    setState(() {
                      userData = null;
                      session = null;
                      branch = '';
                      semester = '';
                    });
                  }
                }
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> changeVisibility(bool value) async{
    userData?.isProfileVisible = value;
    bool res = await SettingsDatabase().writeData(SettingsArgs.visibility, userData);
    if(res){
      setState(() {
        isProfileVisible = value;
      });
    }else{
      userData?.isProfileVisible = !value;
    }
  }

  // void branchSelectDialogue(BuildContext context) {
  //   List<String> branches = ['CS', 'EC', 'ME', 'SM', 'DS'];
  //   List<Widget> widList = [];

  //   branches.forEach((el)=>widList.add(
  //       TextButton(
  //             onPressed: () async{
  //               // Close the dialog
  //               bool res = await SettingsDatabase().writeData(SettingsArgs.branch, el);
  //               if(res){
  //                 setState(() {
  //                   branch = el;
  //                 });
  //               }
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(el),
  //           ),
  //     )
  //   );

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         actions: widList,
  //         actionsAlignment: MainAxisAlignment.center,
  //       );
  //     },
  //   );
  // }

  // void semSelectDialogue(BuildContext context) {
  //   List<int> sems = [1,2,3,4,5,6,7,8];
  //   List<Widget> widList = [];

  //   sems.forEach((el)=>widList.add(
  //       TextButton(
  //             onPressed: () async{
  //               // Close the dialog
  //               bool res = await SettingsDatabase().writeData(SettingsArgs.sem, el.toString());
  //               if(res){
  //                 setState(() {
  //                   semester = el.toString();
  //                 });
  //               }
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(el.toString()),
  //           ),
  //     )
  //   );

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         actions: widList,
  //         actionsAlignment: MainAxisAlignment.center,
  //       );
  //     },
  //   );
  // }
}
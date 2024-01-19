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

  final platformsMap = <DevicePlatform, String>{
    DevicePlatform.device: 'Default',
    DevicePlatform.android: 'Android',
    DevicePlatform.iOS: 'iOS',
    DevicePlatform.web: 'Web',
    DevicePlatform.fuchsia: 'Fuchsia',
    DevicePlatform.linux: 'Linux',
    DevicePlatform.macOS: 'MacOS',
    DevicePlatform.windows: 'Windows',
  };
  DevicePlatform selectedPlatform = DevicePlatform.iOS;

  late SettingsInfo? userData = null;

  Future<void> func() async{
    SettingsInfo data = await SettingsDatabase().getUser();
    setState(() {
      userData = data;
    });
    print(userData);
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
                    Text(userData?.email??'', style: TextStyle(color: AppTheme.deactivatedText),)
                  ],
                ),
                enabled: session != null,
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.logout),
                title: session != null? Text('Sign out'):Text('Sign in'),
                onPressed: (_){
                  showAlertDialog(context);
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Security'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: Icon(Icons.phonelink_lock),
                title: Text('Lock app in background'),
              ),
              SettingsTile.switchTile(
                onToggle: (_) {},
                initialValue: true,
                leading: Icon(Icons.fingerprint),
                title: Text('Use fingerprint'),
                description: Text(
                  'Allow application to access stored fingerprint IDs',
                ),
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
                  setState(() {
                    userData = null;
                    session = null;
                  });
                }
                else Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => AuthScreen()),
                );
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
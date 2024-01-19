import 'package:admin/main.dart';
import 'package:admin/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsDatabase extends ChangeNotifier{
  
  void writeData(String name, dynamic data){
    final mybox = Hive.box('testBox');
    if(name == 'sem'){
      mybox.put('settings.sem', data);
      print(mybox.get('settings.sem'));
    }
    else if(name == 'mess'){
      mybox.put('settings.mess', data);
      print(mybox.get('settings.mess'));
    }
  }

  int getData(String name){
    final mybox = Hive.box('testBox');
    late int data = 0;
    if(name == 'sem'){
      data = mybox.get('settings.sem');
    }
    else if(name == 'mess'){
      data = mybox.get('settings.mess');
    }
    return data;
  }

  Future<SettingsInfo> getUser() async {
    late SettingsInfo userData;
    late var data;
    try {
      final userId = supabase.auth.currentUser!.id;
      data =
          await supabase.from('profiles').select().eq('id', userId).single();
    } catch (error) {
      data = null;
    } finally {
      userData = SettingsInfo(
        email: data['email'],
        group: data['group'],
        mess: data['mess'],
        sem: data['sem']
      );
      return userData;
    }
  }
}
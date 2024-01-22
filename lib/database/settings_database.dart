import 'package:admin/main.dart';
import 'package:admin/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum SettingsArgs {branch, sem, mess}

class SettingsDatabase extends ChangeNotifier{
  final userId = supabase.auth.currentUser!.id;
  Future<bool> writeData(SettingsArgs name, dynamic data) async{
    final mybox = Hive.box('testBox');
    try{
      if(name == SettingsArgs.branch){
        await supabase.from('profiles').update({'branch':data}).eq('id', userId);
        mybox.put('settings.branch', data);
      }
      else if(name == SettingsArgs.sem){
        await supabase.from('profiles').update({'sem':data}).eq('id', userId);
        mybox.put('settings.sem', data);
      }
      else if(name == SettingsArgs.mess){
        await supabase.from('profiles').update({'mess':data}).eq('id', userId);
        mybox.put('settings.mess', data);
      }
      return true;
    }catch(err){
      return false;
    }
  }

  dynamic getData(SettingsArgs name){
    final mybox = Hive.box('testBox');
    late dynamic data = 0;
    if(name == SettingsArgs.branch){
      data = mybox.get('settings.branch');
    }
    else if(name == SettingsArgs.sem){
      data = mybox.get('settings.sem');
    }
    else if(name == SettingsArgs.mess){
      data = mybox.get('settings.mess');
    }
    return data;
  }

  void clearData() async{
    final mybox = Hive.box('testBox');
    mybox.deleteAll({'settings.branch', 'settings.sem', 'settings.mess'});
  }

  Future<SettingsInfo> getInitialUser() async {
    late SettingsInfo userData;
    late var data;
    try {
      data =
          await supabase.from('profiles').select().eq('id', userId).single();
    } catch (error) {
      data = null;
      this.clearData();
    } finally {
      userData = SettingsInfo(
        email: data['email'],
        branch: data['branch'],
        group: data['group'],
        mess: data['mess'],
        sem: data['sem']
      );
      
      if(userData.email!=null){
        final mybox = Hive.box('testBox');
        mybox.put('user', userData);
      }
      return userData;
    }
  }

  Future<SettingsInfo> getUser() async {
    late SettingsInfo userData;
    late var data;
    try {
      // final mybox = await Hive.box('testBox');
      data = await supabase.from('profiles').select().eq('id', userId).single();
          //await mybox.get('user');
    } catch (error) {
      data = null;
      this.clearData();
    } finally {
      userData = SettingsInfo(
        email: data['email'],
        branch: data['branch'],
        group: data['group'],
        mess: data['mess'],
        sem: data['sem'],
        roll: data['roll']
      );
      return userData;
    }
  }

  Future updateUser()async{
    
  }
}
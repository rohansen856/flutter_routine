import 'package:admin/main.dart';
import 'package:admin/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum SettingsArgs {branch, sem, group, mess, visibility}

class SettingsDatabase extends ChangeNotifier{
  final userId = supabase.auth.currentUser!.id;

  late Box<SettingsInfo> myBox = Hive.box<SettingsInfo>('testBox');

  Future<bool> writeData(SettingsArgs name, SettingsInfo? data) async{
    try{
      if(name == SettingsArgs.visibility){
        await supabase.from('profiles').update({'visibility':data?.isProfileVisible}).eq('id', userId);
        await myBox.put('user', data!);
      }
      else if(name == SettingsArgs.group){
        await supabase.from('profiles').update({'group':data?.group}).eq('id', userId);
        myBox.put('settings.branch', data!);
      }
      // else if(name == SettingsArgs.sem){
      //   await supabase.from('profiles').update({'sem':data}).eq('id', userId);
      //   myBox.put('settings.sem', data);
      // }
      // else if(name == SettingsArgs.mess){
      //   await supabase.from('profiles').update({'mess':data}).eq('id', userId);
      //   myBox.put('settings.mess', data);
      // }
      return true;
    }catch(err){
      return false;
    }
  }

  void clearData() async{
    myBox.delete('user');
  }

  Future<SettingsInfo> getInitialUser() async {
    late SettingsInfo userData;
    late dynamic data;
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
        sem: data['sem'],
        roll: data['roll'],
        isProfileVisible: data['visibility']
      );
      if(userData.email!=null){
        print(userData.group);
        try{await myBox.put('user', userData);}catch(e){}
      }
      return userData;
    }
  }

  Future<SettingsInfo> getUser() async {
    late SettingsInfo userData;
    late SettingsInfo? data;
    try {
      // final mybox = await Hive.box('testBox');
      data = //await supabase.from('profiles').select().eq('id', userId).single();
          await myBox.get('user');
    } catch (error) {
      data = null;
      this.clearData();
    } finally {
      userData = SettingsInfo(
        email: data!.email,
        branch: data.branch,
        group: data.group,
        mess: data.mess,
        sem: data.sem,
        roll: data.roll,
        isProfileVisible: data.isProfileVisible
      );
      return userData;
    }
  }

  Future updateUser()async{
    
  }
}
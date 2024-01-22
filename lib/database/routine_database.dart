import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:admin/main.dart';

class RoutineDatabase extends ChangeNotifier{
  static Future<void> initDatabase() async{
    final mybox = Hive.box('testBox');
    // if(!(mybox.get('settings.sem')))return;
    final data = await supabase.from('routine').select().eq('branch', 'BCS');
    mybox.put('routine', data);
  }

  Future<List<Map<String, dynamic>>> getRoutine(int day, String branch, int sem) async{
    // final mybox = Hive.box('testBox');
    List<Map<String, dynamic>> data = await supabase.from('routine')
    .select()
    .eq('branch', branch)
    .eq('day', day)
    .eq('sem', sem);
    return data;
  }
}
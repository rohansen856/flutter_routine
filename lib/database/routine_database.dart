import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:admin/main.dart';

class RoutineDatabase extends ChangeNotifier{
  Future<void> initDatabase() async{
    final mybox = Hive.box('testBox');
    // if(!(mybox.get('settings.sem')))return;
    final data = await supabase.from('routine').select();
    mybox.put('routine', data);
  }

  Future<void> getRoutine(int day, int sem) async{
    final mybox = Hive.box('testBox');
    // if(mybox.get('routine'))print(mybox.get('routine'));
    List<dynamic> data = await supabase.from('routine').select().eq('day', day).eq('sem', sem);
    mybox.put('routine', data);
    print(mybox.get('routine'));
  }
}
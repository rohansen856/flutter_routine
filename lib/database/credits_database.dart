import 'package:flutter/material.dart';
import 'package:admin/main.dart';

class CreditsDatabase extends ChangeNotifier{

  Future<List<Map<String, dynamic>>> getCredits(String branch, int sem) async{
    // final mybox = Hive.box('testBox');
    List<Map<String, dynamic>> data = await supabase.from('credits')
    .select()
    .eq('branch', branch)
    .eq('sem', sem);
    return data;
  }
}
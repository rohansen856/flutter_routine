import 'package:admin/database/routine_database.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var users;

  void getGithubUsers() async {
    try {
      var response = await RoutineDatabase().getModifications();      //Dio().get("http://192.168.31.232:3000/api/routine");
      List<String> ids = response.map((obj) => obj["class_id"].toString()).toList();

      setState(() {
        users = ids;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getGithubUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(users.toString())
    );
  }
}
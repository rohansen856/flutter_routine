import 'package:admin/animation/text_load_animation.dart';
import 'package:admin/main.dart';
import 'package:admin/screens/explore/widgets/github_users.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'widgets/header.dart';

class ExploreScreen extends StatefulWidget {
    const ExploreScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  @override
  Widget build(BuildContext context) {
    return AllUsers();
  }
}

class AllUsers extends StatefulWidget {
  const AllUsers({ Key? key }) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  var users;

  void getAllUsers() async {
    try {
      var response = await supabase.from('profiles').select();

      setState(() {
        users = response;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getAllUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: AppTheme.bgColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: const Header(),
        ),
      ),
      body: users != null ? ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://utfs.io/f/d2d26dc2-ca51-4f4b-8019-ca3d391dbaa8-t8r22.png'),
            ),
            title: Text(
              "${(DateTime.now().year- 2000 - users[index]['year']).toString()}st year ${users[index]['branch'].toString().substring(1,3).toUpperCase()}"
            ),
            subtitle: Text(users[index]['email']),
            onTap: () => {},
          );
        },
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}

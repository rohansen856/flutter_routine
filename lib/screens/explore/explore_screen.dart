import 'package:admin/main.dart';
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
  List users=[];

  Future<void> getAllUsers() async {
    List response=[];
    try {
      response = await supabase.from('profiles').select().eq('visibility', true);
    } catch (e) {
      response = [];
    }
    finally{
      setState(() {
        users = response;
      });
    }
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
      body: users.length>0 ? ListView.builder(
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

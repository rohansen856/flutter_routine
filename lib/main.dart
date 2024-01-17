import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/database/routine_database.dart';
import 'package:admin/screens/auth/auth_screen.dart';
import 'package:admin/screens/auth/splash_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  await Hive.initFlutter();
  await Hive.openBox('testBox');
  WidgetsFlutterBinding.ensureInitialized();

  const String supabaseUrl = "https://yyivbsxjptvxhmxtrqug.supabase.co";
  const String supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl5aXZic3hqcHR2eGhteHRycXVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ5NDgzMjAsImV4cCI6MjAyMDUyNDMyMH0.vnxZenLPuh9kXe2xcTYb4FMVCmTgKy7EcvE-CBexvP4";

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  await RoutineDatabase.initDatabase();

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/': (_) => SplashPage(),
        '/login': (_) => AuthScreen(),
        '/home': (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
          ],
          child: MainScreen(),
        ),
      },
    );
  }
}

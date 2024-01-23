// import 'package:admin/screens/auth/auth_screen.dart';
import 'package:admin/controllers/notification_controller.dart';
import 'package:admin/screens/auth/auth_screen.dart';
import 'package:admin/screens/auth/splash_screen.dart';
import 'package:admin/screens/main_screen.dart';
import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('testBox');

  const String supabaseUrl = "https://rfgzjoeivlveakoqxyfk.supabase.co";
  const String supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJmZ3pqb2Vpdmx2ZWFrb3F4eWZrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU2NTQzMjUsImV4cCI6MjAyMTIzMDMyNX0.3pSb8cG6jkcvy5R9XC3C9rG43kGkIfvtguLC5rf_eMs";

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  await NotificationController.initializeLocalNotifications();
  await NotificationController.initializeIsolateReceivePort();

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  
  static final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>();

  static Color mainColor = const Color(0xFF9D50DD);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    NotificationController.createNewNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusOrbit',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppTheme.bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: AppTheme.secondaryColor,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => SplashPage(),
        '/login': (_) => AuthScreen(),
        '/home': (_) => MainScreen()
      },
    );
  }
}

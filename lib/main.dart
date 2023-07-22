import 'package:amazon_clone/common/screens/error_screen.dart';
import 'package:amazon_clone/common/screens/loader.dart';
import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:amazon_clone/features/authentication/controller/auth_controller.dart';
import 'package:amazon_clone/features/authentication/screens/login_screen.dart';
import 'package:amazon_clone/features/homePage/screen/landing_screen.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: GlobalVariables.backgroundColor));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  String? token = '';
  String? userid = '';

  void checktoken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    token = sp.getString('x-auth-token');
    userid = sp.getString('user-id');
    setState(() {});
  }

  @override
  void initState() {
    checktoken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: userid == ''
          ? const LoginScreen()
          : ref.watch(authControllerGetUsetDetails).when(
              data: (data) {
                return const LandingScreen();
              },
              error: (error, stackTrace) {
                return ErrorScreen(error: error.toString());
              },
              loading: () {
                return const Loader();
              },
            ),
      // home: const LoginScreen(),
    );
  }
}

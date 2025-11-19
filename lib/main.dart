// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:qc_doctor/Data/APIServices/MyHttpOverrides.dart';
// import 'package:qc_doctor/Screens/SplashScreens/splashscreen.dart';
//
// // Developer : Md Asgar Ali
// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // // Set transparent status bar globally
//   // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//   //   statusBarColor: Colors.transparent, // Transparent status bar
//   //   statusBarIconBrightness: Brightness.light, // Change to Brightness.light if needed
//   // ));
//
//   HttpOverrides.global = new MyHttpOverrides();
//   runApp(MyApp());
// }
//
// class MyApp  extends StatelessWidget{
//   MyApp();
//
//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(0xFF126086),));
//
//     return MaterialApp(
//       title : 'QC Doctor',
//       initialRoute: '/',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//       ),
//
//       builder: (context,child) {
//         return MediaQuery(
//             data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//             child: child!);
//       },
//       home: SplashScreen(),
//     );
//
//   }
// }
//
//
//
//
//
//

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:newfolder/Data/APIServices/MyHttpOverrides.dart';
import 'package:newfolder/Screens/Access_Screen/access_screen.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Login/loginpage.dart';
import 'package:newfolder/Screens/OnBoarding/onboarding_screen.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/utils/cart_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // Pre-save mobile number
  final storage = FlutterSecureStorage();

  String? value = await storage.read(key: 'mpinEnabled');
  bool isEnabled = value == 'true';

  final isFirstLaunch = await UserSecureStorage.getIsFirstLaunchDone() ?? "NO";

  final String? isUserId = await UserSecureStorage.getUsernameid();
  Widget initialScreen;
  if (isEnabled && isUserId!= null && isUserId.isNotEmpty) {
    initialScreen = AccessScreen();
    // initialScreen = LoginPage();
  } else if (isFirstLaunch != "YES") {
    await UserSecureStorage.setIsFirstLaunchDone("YES");
    initialScreen = SplashLogoScreen(); // with GIF
  } else {
    final isLoggedIn = await UserSecureStorage.getIfLogged() ?? "NO";
    // final isLoggedOut = await UserSecureStorage.getIfLoggedOut() ?? "NO";

    if (isLoggedIn == "YES") {
      initialScreen = LoginPage();
    } else if (isLoggedIn == "YES") {
      initialScreen = HomePageMain();
    } else {
      initialScreen = OnboardingScreen();
    }
  }

  // runApp(MyApp(initialScreen: initialScreen));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(initialScreen: initialScreen),
    ),
  );

}

// void main(){
//   runApp(MaterialApp(
//     title: 'My App',
//     debugShowCheckedModeBanner: false,
//     home: SplashLogoScreen(),
//   ));
// }
class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Use dark icons (or light)
    ));
    return MaterialApp(
      title: 'QC Patient',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: ClampingScrollPhysics(), // Applies to all scrollables
      ),
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadePageTransitionsBuilder(),
            TargetPlatform.iOS: FadePageTransitionsBuilder(),
            TargetPlatform.windows: FadePageTransitionsBuilder(),
            TargetPlatform.linux: FadePageTransitionsBuilder(),
            TargetPlatform.macOS: FadePageTransitionsBuilder(),
          },
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.4),),
          child: child!,
        );
      },
      home: initialScreen,
    );
  }
}

class SplashLogoScreen extends StatefulWidget {
  @override
  State<SplashLogoScreen> createState() => _SplashLogoScreenState();
}

class _SplashLogoScreenState extends State<SplashLogoScreen> {
  @override
  void initState() {
    super.initState();
    // initializeDefaultCredentials();
    Future.delayed(Duration(seconds: 5), () async {
      final isLoggedIn = await UserSecureStorage.getIfLogged() ?? 'NO';
      // final isLoggedOut = await UserSecureStorage.getIfLoggedOut() ?? 'NO';

      Widget next;
      if (isLoggedIn == "YES") {
        next = LoginPage();
      } else if (isLoggedIn == "YES") {
        next = HomePageMain();
      } else {
        next = OnboardingScreen();
      }

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => next),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.080,
                  right: MediaQuery.of(context).size.height * 0.080),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Now display the GIF
                  Container(
                    // height: MediaQuery.of(context).size.height *
                    //     0.060, // Set the height to match the text size
                    width: MediaQuery.of(context)
                        .size
                        .width, // Set the width based on your requirements
                    child: AspectRatio(
                      aspectRatio: 150 / 32,
                      child: Image.asset(
                        'assets/quadracyte_logonew.gif', // Your GIF file
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FadePageTransitionsBuilder extends PageTransitionsBuilder {
  const FadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

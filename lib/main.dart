import 'dart:io';
import 'package:ICare/auth/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ICare/icare_home_screen.dart';
import 'package:ICare/theme.dart';
import 'package:splashscreen/splashscreen.dart';

import 'auth/login/login_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter ICare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: ICareAppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home:  new SplashScreen(
      seconds: 3,
      gradientBackground: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientStart,
                        Theme.Colors.loginGradientEnd
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
      navigateAfterSeconds: new AfterSplash(),
      image: new Image.asset('assets/fitness_app/icon_heart_edited.png',scale: 6.0,),
      backgroundColor: Colors.white,
      photoSize: 100.0,
      loaderColor: Colors.white,
      ),
      routes: <String,WidgetBuilder>{
        '/HomePage' : (BuildContext context) => new FitnessAppHomeScreen(),
        '/LoginPage' : (BuildContext context) => new LoginPage(),
      },
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
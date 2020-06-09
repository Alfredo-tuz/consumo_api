import 'package:consumo_api/pages/home.dart';
import 'package:consumo_api/pages/login.dart';
import 'package:consumo_api/pages/sign_up.dart';
import 'package:consumo_api/pages/splash.dart';
import 'package:consumo_api/providers/me.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_)=>Me()
        )
      ],
      child:MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
        routes: {
          "login":(context)=>LoginPage(),
          "splash":(context)=>SplashPage(),
          "signup":(context)=>SignUpPage(),
          "home":(context)=>HomePage()
        },
      ),
    );
  }
}
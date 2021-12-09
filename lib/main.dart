import 'package:flutter/material.dart';
import 'package:to_do_tasks/widgets/splash_screen.dart';
import 'package:to_do_tasks/widgets/home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async{
  await Hive.initFlutter();
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashScreen(),//const Home
        '/home': (context) => Home(),
      },
/*      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: LoginView(),

      ),*/
    ),
  );
}



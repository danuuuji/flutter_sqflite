import 'package:flutter/material.dart';
import 'package:flutter_sqflite/src/pages/authorization_page.dart';
import 'package:flutter_sqflite/src/pages/bloc/auth_cubit.dart';
import 'package:flutter_sqflite/src/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQfLite testing',
      routes: {
        '/' : (BuildContext context) => AuthorizationPage(),
        '/auth' : (BuildContext context) => AuthorizationPage(),
        '/home' : (BuildContext context) => const HomePage(),
      },
      initialRoute: (AuthCubit.checkInDB()) ? '/home' : '/auth',

    );
  }
}


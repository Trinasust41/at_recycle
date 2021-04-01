import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newserverdemo/screens/chat_screen.dart';
import 'package:newserverdemo/screens/chat_screen2.dart';
import 'package:newserverdemo/screens/home_screen.dart';
import 'package:newserverdemo/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '@Protocol Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ChatScreen1.id: (context) => ChatScreen1(),
        ChatScreen2.id: (context)=> ChatScreen2(),
      },


    );
  }
}

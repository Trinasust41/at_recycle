import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newserverdemo/screens/add_dish_screen.dart';
import 'package:newserverdemo/screens/chat_screen.dart';
import 'package:newserverdemo/screens/chat_screen2.dart';
import 'package:newserverdemo/screens/home_screen.dart';
import 'package:newserverdemo/screens/home_screen2.dart';
import 'package:newserverdemo/screens/login_screen.dart';
import 'package:newserverdemo/screens/other_screen.dart';
import 'package:newserverdemo/screens/dish_page.dart';
import 'package:newserverdemo/screens/share_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '@Protocol Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ChatScreen1.id: (context) => ChatScreen1(),
        ChatScreen2.id: (context)=> ChatScreen2(),
        HomeScreen2.id: (context)=> HomeScreen2(shouldReload: false),
        DishScreen.id: (context) => DishScreen(),
        OtherScreen.id: (context) => OtherScreen(),




      },


    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:at_commons/at_commons.dart';
import 'package:newserverdemo/screens/chat_screen.dart';
import 'package:newserverdemo/screens/home_screen2.dart';
import 'package:newserverdemo/services/server_demo_service.dart';
import '../utils/at_conf.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO: Instantiate variables
  //update
  String _key;
  String _value;

  // lookup
  TextEditingController _lookupTextFieldController = TextEditingController();
  String _lookupKey;
  String _lookupValue = '';

  // scan
  List<String> _scanItems = List<String>();

  // service
  ServerDemoService _serverDemoService = ServerDemoService.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Home',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //update
              Flexible(
                fit: FlexFit.loose,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.cyan[700],
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.all(10),

                        child: FlatButton(
                          child: Text('Chat'),
                          color: Colors.cyan[700],
                          textColor: Colors.white,
                          // TODO: Complete the onPressed function
                          onPressed:  (){
                            Navigator.pushNamed(context,ChatScreen1.id);
                          },
                        ),

                      ),

                    ],
                  ),

                ),




              ),

              Flexible(

                fit: FlexFit.loose,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.cyan[700],
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Container(

                        margin: EdgeInsets.all(10),

                        child: FlatButton(
                          child: Text('Share'),
                          color: Colors.cyan[700],
                          textColor: Colors.white,
                          // TODO: Complete the onPressed function
                          onPressed:  (){
                            Navigator.pushNamed(context,HomeScreen2.id);
                          },
                        ),
                      ),

                    ],
                  ),

                ),



              ),

            ],
          ),
        ),
      ),
    );
  }

  // TODO: add the _scan, _update, and _lookup methods
  /// Create instance of an AtKey and pass that
  /// into the put() method with the corresponding
  /// _value string.
 
}

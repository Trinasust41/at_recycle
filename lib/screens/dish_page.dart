import 'package:newserverdemo/components/dish_widget.dart';
import 'package:newserverdemo/components/rounded_button.dart';
import 'package:at_commons/at_commons.dart';
import 'package:newserverdemo/components/rounded_button.dart';
import 'package:newserverdemo/services/server_demo_service.dart';
import 'package:flutter/cupertino.dart';
import 'login_screen.dart';
import 'home_screen2.dart';
import 'share_screen.dart';
import 'package:flutter/material.dart';

class DishPage extends StatelessWidget {
  final DishWidget dishWidget;
  static const String id = 'dishpage';

  final _serverDemoService = ServerDemoService.getInstance();

  DishPage({@required this.dishWidget});


  convertStringsToWidgets(List<dynamic> ingredients) {
    List<Text> ingredientList = [];
    for (dynamic ingredient in ingredients) {
      ingredientList.add(Text((ingredient.toString())));
    }
    return ingredientList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dishWidget.title,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.white70,
                  child: Center(
                    child: Column(
                      children: <Widget>[


                        Row(children: <Widget>[
                            Expanded(
                              child: Image(

                              image:dishWidget.imageURL == null
                                    ? AssetImage('assets/mahi.png')
                                    : NetworkImage(dishWidget.imageURL),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Divider(
                            color: Colors.black87,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                            children: <Widget>[
                              Expanded(
                               child: Align(alignment:Alignment.centerLeft,
                                child: Text(

                                  'Product name: '+ dishWidget.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black87,

                                  ),
                                ),
                               )   ),]),

                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Catagories: ' +   dishWidget.description,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Price: ' + dishWidget.ingredients,
                              style: TextStyle(
                                color:  Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            dishWidget.prevScreen == HomeScreen2.id
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RoundedButton(
                  path: () {
                    _delete(context);
                  },
                  text: 'Remove',
                  width: 180,
                  color: Colors.redAccent,
                ),
                RoundedButton(
                  path: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShareScreen(dishWidget: this.dishWidget)),
                    );
                  },
                  text: 'Share',
                  width: 180,
                  color:  Colors.cyan[700],
                ),
              ],
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  /// Deletes a key/value pair in the secondary server of
  /// the logged-in @sign.
  _delete(BuildContext context) async {
    if (dishWidget.title != null) {
      AtKey atKey = AtKey();
      atKey.key = dishWidget.title;
      atKey.sharedWith = atSign;
      await _serverDemoService.delete(atKey);
    }
    Navigator.of(context).pushNamedAndRemoveUntil(
        dishWidget.prevScreen, (Route<dynamic> route) => false,
        arguments: true);
  }
}

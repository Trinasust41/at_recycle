import 'package:newserverdemo/components/dish_widget.dart';
import '../utils/at_conf.dart';
import 'package:newserverdemo/utils/constants.dart' as constant;
import 'add_dish_screen.dart';
import 'other_screen.dart';
import 'login_screen.dart';
import 'package:at_commons/at_commons.dart';
import 'package:newserverdemo/services/server_demo_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen2 extends StatefulWidget {
  static final String id = 'home2';
  final bool shouldReload;

  const HomeScreen2({
    this.shouldReload,
  });

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2>
    with SingleTickerProviderStateMixin {
  final List<DishWidget> sortedWidgets = [];
  ServerDemoService _serverDemoService = ServerDemoService.getInstance();

  checkReload() {
    if (widget.shouldReload) {
      setState(() {});
    }
  }

  @override
  void initState() {
    checkReload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome, ' + atSign,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: FutureBuilder(
                    future: _scan(),
                    builder:
                        (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        // Returns a list of attributes for each dish.
                        List<String> dishAttributes = snapshot.data;
                        print(snapshot.data);
                        List<DishWidget> dishWidgets = [];
                        for (String attributes in dishAttributes) {
                          // Populate a DishWidget based on the attributes string.
                          List<String> attributesList =
                          attributes.split(constant.splitter);
                          if (attributesList.length >= 3) {
                            DishWidget dishWidget = DishWidget(
                              title: attributesList[0],
                              description: attributesList[1],
                              ingredients: attributesList[2],
                              imageURL: attributesList.length == 4
                                  ? attributesList[3]
                                  : null,
                              prevScreen: HomeScreen2.id,
                            );
                            dishWidgets.add(dishWidget);
                          }
                        }
                        return SafeArea(
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Post History',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.keyboard_arrow_right,
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, OtherScreen.id);
                                        },
                                      )
                                    ]),
                              ),
                              Column(
                                children: dishWidgets,
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                            'An error has occurred: ' + snapshot.error.toString());
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton:FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Give a Post"),

        backgroundColor:  Colors.cyan[700],
        foregroundColor: Colors.white,

        onPressed: () {
          Navigator.pushNamed(context, DishScreen.id)
              .then((value) => setState(() {}));
        },
      ),
    );
  }

  /// Scan for [AtKey] objects with the correct regex.
  _scan() async {
    List<AtKey> response;
    String regex = '^(?!cached).*cookbook.*';
    response = await _serverDemoService.getAtKeys(regex: regex);
    List<String> responseList = [];
    for (AtKey atKey in response) {
      String value = await _lookup(atKey);
      value = atKey.key + constant.splitter + value;
      responseList.add(value);
    }
    return responseList;
  }

  /// Look up a value corresponding to an [AtKey] instance.
  Future<String> _lookup(AtKey atKey) async {
    if (atKey != null) {
      return await _serverDemoService.get(atKey);
    }
    return '';
  }
}

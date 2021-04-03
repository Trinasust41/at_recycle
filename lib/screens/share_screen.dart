import 'package:newserverdemo/components/dish_widget.dart';
import 'package:newserverdemo/components/rounded_button.dart';
import 'package:at_commons/at_commons.dart';
import 'login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'package:newserverdemo/services/server_demo_service.dart';

class ShareScreen extends StatefulWidget {
  static final String id = 'share';
  final DishWidget dishWidget;

  ShareScreen({@required this.dishWidget});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  String _otherAtSign;
  List<String> _atSigns;
  ServerDemoService _serverDemoService = ServerDemoService.getInstance();

  initList() {
    List<String> otherAtSigns = at_demo_data.allAtsigns;
    otherAtSigns.remove(atSign);
    setState(() {
      _atSigns = otherAtSigns;
    });
  }

  @override
  void initState() {
    initList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Share'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Hero(
                      tag: 'choice chef',
                      child: SizedBox(
                        height: 200,
                        child: Image.asset(
                          'assets/mahi.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Center(
                      child: DropdownButton<String>(
                        hint: Text('\tPick an @sign'),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                        ),
                        iconSize: 24,
                        dropdownColor: Colors.cyan[700],
                        elevation: 16,
                        style: TextStyle(fontSize: 20.0, color: Colors.black87),
                        onChanged: (String newValue) {
                          setState(() {
                            _otherAtSign = newValue;
                          });
                        },
                        value: _otherAtSign != null ? _otherAtSign : null,
                        items: _atSigns == null ? [] : _atSigns
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RoundedButton(
                    text: 'SHARE',
                    color:  Colors.white,
                    path: () async => await _share(context, _otherAtSign),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _share(BuildContext context, String sharedWith) async {
    if (sharedWith != null) {
      AtKey lookup = AtKey()
        ..key = widget.dishWidget.title
        ..sharedWith = atSign;

      String value = await _serverDemoService.get(lookup);

      var metadata = Metadata()..ttr = -1;
      AtKey atKey = AtKey()
        ..key = widget.dishWidget.title
        ..metadata = metadata
        ..sharedBy = atSign
        ..sharedWith = _otherAtSign;

      var operation = OperationEnum.update;
      await _serverDemoService.notify(atKey, value, operation);
      Navigator.pop(context);
    }
  }
}

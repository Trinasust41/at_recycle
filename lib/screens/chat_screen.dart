import 'package:at_chat_flutter/at_chat_flutter.dart';
import 'package:atsign_authentication_helper/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:at_demo_data/at_demo_data.dart' as at_demo_data;
import 'package:newserverdemo/services/server_demo_service.dart';

import 'chat_screen2.dart';
import '../utils/at_conf.dart';
import 'package:at_commons/at_commons.dart';

import '../utils/at_conf.dart';
class ChatScreen1 extends StatefulWidget {
  static final String id = 'chat1';
  @override
  _ChatScreen1State createState() => _ChatScreen1State();
}

class _ChatScreen1State extends State<ChatScreen1> {
  ServerDemoService serverDemoService = ServerDemoService.getInstance();
  String activeAtSign = '';
  GlobalKey<ScaffoldState> scaffoldKey;
  List<String> atSigns;
  String chatWithAtSign;
  bool showOptions = false;
  bool isEnabled = true;

  @override
  void initState() {
    // TODO: Call function to initialize chat service.
    getAtSignAndInitializeChat();
    scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Welcome $activeAtSign!')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Choose an @sign to chat with',
                style: TextStyle(fontSize: 25),
              ),
            ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // Text('Choose an @sign to chat with'),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: DropdownButton<String>(
                hint:  Text('\tPick an @sign'),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                ),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black87
                ),
                underline: Container(
                  height: 2,
                  color: Colors.cyan[700],
                ),
                onChanged: isEnabled ? (String newValue) {
                  setState(() {
                    chatWithAtSign = newValue;
                    isEnabled = false;
                  });
                } : null,
                disabledHint: chatWithAtSign != null ? Text(chatWithAtSign)
                    : null,
                value: chatWithAtSign != null ? chatWithAtSign : null,
                items: atSigns == null ? null : atSigns
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            showOptions ? Column(
              children: [
                SizedBox(height: 20.0),
                FlatButton(
                  onPressed: () {
                    scaffoldKey.currentState
                        .showBottomSheet((context) => ChatScreen());
                  },
                  child:Card(
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
              child: Text('Open to chat'),
              color: Colors.cyan[700],
              textColor: Colors.white,
              // TODO: Complete the onPressed function

            ),
          ),

        ],
      ),

    ),

    ),
                SizedBox(height: 20.0),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ChatScreen2.id);
                  },
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
              child: Text('Navigation'),
              color: Colors.cyan[700],
              textColor: Colors.white,
              // TODO: Complete the onPressed function

            ),
          ),

        ],
      ),

    ),

    )
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    if (chatWithAtSign != null &&
                        chatWithAtSign.trim() != '') {
                      // TODO: Call function to set receiver's @sign
                      setAtsignToChatWith();
                      setState(() {
                        showOptions = true;
                      });
                    } else {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                children: [Text('@sign Missing!')],
                              ),
                              content: Text('Please enter an @sign'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close'),
                                )
                              ],
                            );
                          });
                    }
                  },
                  child:Flexible(

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
                              child: Text('Options'),
                              color: Colors.cyan[700],
                              textColor: Colors.white,
                              // TODO: Complete the onPressed function

                            ),
                          ),

                        ],
                      ),

                    ),



                  ),
                )
                  ],
            ),
          ],
        ),
      ),
    );
  }
  // TODO: Write function to initialize the chatting service
  getAtSignAndInitializeChat() async {
    String currentAtSign = await serverDemoService.getAtSign();
    setState(() {
      activeAtSign = currentAtSign;
    });
    List<String> allAtSigns = at_demo_data.allAtsigns;
    allAtSigns.remove(activeAtSign);
    setState(() {
      atSigns = allAtSigns;
    });
    initializeChatService(
        serverDemoService.atClientServiceInstance.atClient, activeAtSign,
        rootDomain: MixedConstants.ROOT_DOMAIN);
  }
  // TODO: Write function that determines whom you are chatting with
  setAtsignToChatWith() {
    setChatWithAtSign(chatWithAtSign);
  }
}

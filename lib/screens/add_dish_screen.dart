import 'package:newserverdemo/components/rounded_button.dart';
import 'package:newserverdemo/services/server_demo_service.dart';
import 'login_screen.dart';
import 'package:at_commons/at_commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:newserverdemo/utils/constants.dart' as constant;
import 'package:flutter/material.dart';
import 'home_screen2.dart';
// ignore: must_be_immutable
class DishScreen extends StatelessWidget {
  static final String id = "add_dish";
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _title;
  String _ingredients;
  String _description;
  String _imageURL;
  ServerDemoService _serverDemoService = ServerDemoService.getInstance();

  //String get atSign => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post an Ad'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
                key: _formKey,
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
                            height: 120,
                            child: Image.asset(
                              'assets/mahi.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                  TextFormField(


                    decoration: InputDecoration(

                      icon: Icon(Icons.menu,
                        color: Colors.cyan,

                      ),

                      focusColor: Colors.white,
                      fillColor: Colors.green[50],
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Product Name',
                      labelText: 'Product Name',
                    ),
                    validator: (value) =>
                    value.isEmpty ? 'Specify the name of the product' : null,
                    onChanged: (value) {
                      _title= value;
                    },
                  ),

                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(

                        decoration: InputDecoration(
                          icon: Icon(Icons.category,
                            color: Colors.cyan,
                          ),

                          focusColor: Colors.white,
                          fillColor: Colors.green[50],
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Name the Category',
                          labelText: 'Category',
                        ),
                        validator: (value) =>
                        value.isEmpty ? 'Mention the Category' : null,
                        onChanged: (value) {
                          _description= value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(

                          focusColor: Colors.white,
                          fillColor: Colors.green[50],

                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          icon: Icon(Icons.attach_money,color: Colors.cyan,),
                          hintText: 'BDT',
                          labelText: 'Asking Price',
                        ),
                        validator: (value) =>
                        value.isEmpty ? 'Add Price in BDT' : null,
                        onChanged: (value) {
                          _ingredients = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.camera_enhance,color: Colors.cyan,),

                          focusColor: Colors.white,
                          fillColor: Colors.green[50],

                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Link to an image',
                          labelText: 'Image',
                        ),
                        onChanged: (value) {
                          _imageURL = value;
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      RoundedButton(
                        text: 'POST',
                        color: Colors.white,

                        path: () => _update(context),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  /// Add a key/value pair to the logged-in secondary server.
  _update(BuildContext context) async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      String _values = _description + constant.splitter + _ingredients;
      if (_imageURL != null) {
        _values += constant.splitter + _imageURL;
      }
      AtKey atKey = AtKey();
      atKey.key = _title;
      atKey.sharedWith = atSign;
      await _serverDemoService.put(atKey, _values);
      Navigator.pop(context);
    } else {
      print('Not all text fields have been completed!');
    }
  }
}

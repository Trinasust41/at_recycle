import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function path;
  final String text;
  final Color color;
  final double width;

  RoundedButton({@required this.path, this.color, this.text, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.cyan[700],
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: this.path,
          minWidth: this.width == null ? 200 : this.width,
          height: 42,
          child: Text(
            this.text,
            style: TextStyle(
              color: Colors.white,

            ),
          ),
        ),
      ),
    );
  }
}

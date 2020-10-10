import 'package:flutter/material.dart';

class PBTextField extends StatelessWidget {
  final Key key;
  final IconData leadingIcon;
  final String hintText;
  final Function onSaved;
  final Function onChange;
  final String initialValue;
  final bool obscureText;
  final Function validator;
  final TextEditingController controller;
  final int maxLength;
  final TextInputType keyboardType;

  PBTextField({
    this.key,
    @required this.leadingIcon,
    this.hintText,
    this.onSaved,
    this.initialValue,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.maxLength,
    this.onChange,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0), color: Color(0xfff4f8f7)),
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0)),
                color: Color(0xffe8ebea),
              ),
              child: Icon(
                leadingIcon,
                color: Color(0xff424242),
              )),
          Expanded(
            child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  counterText: '',
                  counterStyle: TextStyle(fontSize: 0),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(0, 28, 100, 1.0),
                    fontSize: 20,
                    fontFamily: 'SukhumvitSet',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onSaved: onSaved,
                onChanged: onChange,
                initialValue: initialValue,
                key: key,
                obscureText: obscureText,
                validator: validator,
                maxLength: maxLength,
                keyboardType: keyboardType),
          )
        ],
      ),
    );
  }
}

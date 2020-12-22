import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  CustomTextField(
      {this.onChanged,
        this.icon,
        this.hint,
        this.obsecure = false,
        this.validator,});
  final Icon icon;
  final Function onChanged;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20,top: 20),
      child: TextFormField(
        validator: validator,
        onChanged:onChanged,
        autofocus: true,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'assets/fonts/Montserrat-Medium.ttf'
        ),
        decoration: InputDecoration(
          labelText:hint,
          icon: icon
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomInputTextField extends StatefulWidget {
  final String hintText;
  final bool secure;
  final TextEditingController controller;
  final GlobalKey formKey;

  CustomInputTextField({
    @required this.hintText,
    @required this.secure,
    @required this.controller,
    @required this.formKey,

  });

  @override
  _CustomInputTextFieldState createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: widget.formKey,
        child: TextFormField(
          validator: (value){
            if (value.isEmpty){
              return widget.hintText + "is Required";
            }
            return null;
          },
          controller: widget.controller,
          obscureText: widget.secure,
          decoration: InputDecoration(
            hintText: widget.hintText,
          ),
        ),
      ),
    );
  }
}

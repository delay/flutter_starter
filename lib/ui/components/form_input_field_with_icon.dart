import 'package:flutter/material.dart';
//import '../../services/helpers/helpers.dart';
import '../../services/services.dart';

/*
FormInputFieldWithIcon(
                controller: _email,
                iconPrefix: Icons.link,
                labelText: 'Post URL',
                validator: Validator.notEmpty,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                onChanged: (value) => print('changed'),
                onSaved: (value) => print('implement me'),
              ),
*/

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon(
      {this.controller,
      this.iconPrefix,
      this.labelText,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.onChanged,
      this.onSaved});

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final void Function(String) onChanged;
  final void Function(String) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        )),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.inputBorderColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Palette.focusedinputBorderColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        filled: true,
        prefixIcon: Icon(iconPrefix),
        fillColor: Palette.inputFillColor,
        labelText: labelText,
      ),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
    );
  }
}

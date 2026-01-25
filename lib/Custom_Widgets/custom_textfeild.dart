import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/utils/colors.dart';

class CustomTextfeild extends StatelessWidget {
  CustomTextfeild(
      {super.key,
      required this.keyboard,
      required this.icon,
      required this.color,
      required this.onSaved,
      required this.text,
      required this.validator,
      required this.isObscure});
  TextInputType keyboard;
  dynamic validator;
  dynamic onSaved;
  dynamic text;
  Color color;
  Icon icon;
  bool isObscure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboard,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
      ],
      style: TextStyle(color: color),
      decoration: InputDecoration(
        prefixIcon: icon,
        prefixIconColor: color,
        errorStyle: const TextStyle(fontSize: 15),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: blackColor, style: BorderStyle.solid, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        enabled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: secondColor, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        label: Text(
          text,
          style: TextStyle(color: blackColor),
        ),
      ),
    );
  }
}

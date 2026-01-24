import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/utils/colors.dart';

class CustomTextfeild extends StatelessWidget {
  CustomTextfeild(
      {super.key,
      required this.color,
      required this.hintText,
      required this.onSaved,
      required this.text,
      required this.validator});
  dynamic validator;
  dynamic onSaved;
  dynamic hintText;
  dynamic text;
  Color color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
      ],
      style: TextStyle(color: color),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: secondColor, style: BorderStyle.solid, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: greyColor),
        enabled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: secondColor, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        label: Text(
          text,
          style: TextStyle(color: secondColor),
        ),
      ),
    );
  }
}

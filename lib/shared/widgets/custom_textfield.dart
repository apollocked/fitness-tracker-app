import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_tracker/config/theme/app_theme.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.keyboard,
    this.icon,
    required this.color,
    required this.onSaved,
    required this.text,
    required this.validator,
    required this.isObscure,
    this.input,
    this.controller,
  });
  final TextInputType keyboard;
  final dynamic validator;
  final dynamic onSaved;
  final dynamic text;
  final Color color;
  final Icon? icon;
  final bool isObscure;
  final TextInputFormatter? input;
  final TextEditingController? controller;
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboard,
      enabled: true,
      inputFormatters: widget.input != null ? [widget.input!] : [],
      style: TextStyle(color: colors.textColor),
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        prefixIconColor: widget.color,
        suffixIcon: widget.isObscure
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: colors.subtitleColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        errorStyle: const TextStyle(fontSize: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.color, style: BorderStyle.solid, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: colors.subtitleColor, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        label: Text(
          widget.text,
          style: TextStyle(color: colors.textColor),
        ),
        fillColor: colors.cardColor,
        filled: true,
      ),
    );
  }
}


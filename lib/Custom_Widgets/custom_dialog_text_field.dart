import 'package:flutter/material.dart';
import 'package:myapp/utils/app_theme.dart';

class CustomDialogTextField extends StatefulWidget {
  const CustomDialogTextField(
      {super.key,
      required this.controller,
      required this.text,
      this.isPassword = false});

  final TextEditingController controller;
  final String text;
  final bool isPassword;

  @override
  State<CustomDialogTextField> createState() => _CustomDialogTextFieldState();
}

class _CustomDialogTextFieldState extends State<CustomDialogTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return TextField(
      obscureText: _obscureText,
      controller: widget.controller,
      style: TextStyle(color: colors.textColor),
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: colors.textColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        labelText: widget.text,
        labelStyle: TextStyle(color: colors.subtitleColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

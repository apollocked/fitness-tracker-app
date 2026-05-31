import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fit_tracker/core/theme/app_theme.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class CustomDialogTextField extends StatefulWidget {
  const CustomDialogTextField({
    super.key,
    required this.controller,
    required this.text,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });
  final TextEditingController controller;
  final String text;
  final bool isPassword;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
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
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: primaryColor, style: BorderStyle.solid, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: colors.subtitleColor, style: BorderStyle.solid, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorStyle: const TextStyle(fontSize: 15),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/user_data.dart';

class CustomBodyTypeRatio extends StatefulWidget {
  const CustomBodyTypeRatio({
    super.key,
  });

  @override
  State<CustomBodyTypeRatio> createState() => _CustomBodyTypeRatio();
}

class _CustomBodyTypeRatio extends State<CustomBodyTypeRatio> {
  @override
  Widget build(BuildContext context) {
    var user = currentUser!;
    return Column(
      children: [
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(orangeColor),
          title: Text("No", style: TextStyle(color: getTextColor())),
          value: false.toString(),
          groupValue: user["isBodybuilder"].toString(),
          onChanged: (value) {
            setState(() {
              user["isBodybuilder"] = false;
            });
          },
        ),
        RadioListTile<String>(
          fillColor: WidgetStatePropertyAll(orangeColor),
          title: Text(
            "Yes",
            style: TextStyle(color: getTextColor()),
          ),
          value: true.toString(),
          groupValue: user["isBodybuilder"].toString(),
          onChanged: (value) {
            setState(() {
              user["isBodybuilder"] = true;
            });
          },
        ),
      ],
    );
  }
}

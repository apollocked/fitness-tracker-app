import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/Custom_Widgets/protein_dialog.dart';
import 'package:myapp/Custom_Widgets/select_workout_type.dart';
import 'package:myapp/utils/dark_mode_helper.dart';
import 'package:myapp/utils/assets.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class ProtienIntakePage extends StatefulWidget {
  const ProtienIntakePage({super.key});

  @override
  State<ProtienIntakePage> createState() => _ProtienIntakePageState();
}

class _ProtienIntakePageState extends State<ProtienIntakePage> {
  final GlobalKey<FormState> _form2 = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _calculateProtein() {
    if (_form2.currentState!.validate()) {
      final weight = double.parse(_weightController.text);

      double normalProteins = 0.0;
      double minProteins = 0.0;
      double maxProteins = 0.0;

      if (currentUser!["isBodybuilder"] == false) {
        normalProteins = 0.8 * weight;
      } else {
        maxProteins = 2.0 * weight;
        minProteins = 1.2 * weight;
      }

      normalProteins = (normalProteins * 100).round() / 100;
      maxProteins = (maxProteins * 100).round() / 100;
      minProteins = (minProteins * 100).round() / 100;

      ProteinResultsDialog.showResults(
        context,
        isBodybuilder: currentUser!["isBodybuilder"] ?? false,
        normalProtein: normalProteins,
        minProtein: minProteins,
        maxProtein: maxProteins,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      appBar: customAppBarr(
          "Protein Intake Calculator", orangeColor, getBackgroundColor()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 200,
                child: Image.asset(fit: BoxFit.contain, protienBanner),
              ),
              Form(
                key: _form2,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Are You a BodyBuilder ?',
                        style: TextStyle(fontSize: 16, color: getTextColor())),
                    const CustomBodyTypeRatio(),
                    const SizedBox(height: 15),
                    CustomTextfeild(
                      controller: _weightController,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: orangeColor,
                      onSaved: (value) {},
                      text: "Weight (kg)",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your weight please";
                        }
                        if (double.tryParse(value) == null) {
                          return "Enter a valid number";
                        }
                        return null;
                      },
                      icon: const Icon(Icons.monitor_weight),
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomElevatedButton(
                        onpressed: _calculateProtein,
                        text: "Calculate",
                        color: orangeColor,
                      ),
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/Custom_Widgets/select_gender_radio.dart';
import 'package:myapp/Custom_Widgets/ideal_weight_dialog.dart';

import 'package:myapp/utils/assets.dart';
import 'package:myapp/utils/colors.dart';

class IdealBodyWeightPage extends StatefulWidget {
  const IdealBodyWeightPage({super.key});

  @override
  State<IdealBodyWeightPage> createState() => _IdealBodyWeightPageState();
}

class _IdealBodyWeightPageState extends State<IdealBodyWeightPage> {
  final GlobalKey<FormState> _form1 = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _gender = "Male";

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculateIdealWeight() {
    if (_form1.currentState!.validate()) {
      final height = double.parse(_heightController.text);
      final currentWeight = double.parse(_weightController.text);

      double idealWeight = _gender == "Male"
          ? 50 + (0.91 * (height - 152.4))
          : 45.5 + (0.91 * (height - 152.4));

      idealWeight = (idealWeight * 100).round() / 100;

      IdealWeightResultsDialog.showResults(
        context,
        idealWeight: idealWeight,
        currentWeight: currentWeight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBarr(
          "Ideal Body Weight Calculator", blueColor, backgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 200,
                child: Image.asset(
                  fit: BoxFit.contain,
                  weightBanner,
                ),
              ),
              Form(
                key: _form1,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Select Your Gender',
                        style: TextStyle(color: secondColor, fontSize: 16)),
                    CustomGenderRatio(
                      color: blueColor,
                      initialGender: "Male",
                      onGenderChanged: (value) {
                        setState(() => _gender = value);
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextfeild(
                      controller: _heightController,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: blueColor,
                      onSaved: (value) {},
                      text: "Height (cm)",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your height please";
                        }
                        if (double.tryParse(value) == null) {
                          return "Enter a valid number";
                        }
                        return null;
                      },
                      icon: const Icon(Icons.height),
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(height: 15),
                    CustomTextfeild(
                      controller: _weightController,
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: blueColor,
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
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomElevatedButton(
                        onpressed: _calculateIdealWeight,
                        text: "Calculate",
                        color: blueColor,
                      ),
                    ),
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

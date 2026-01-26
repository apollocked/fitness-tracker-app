import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/Custom_Widgets/custom_elevated_button.dart';
import 'package:myapp/Custom_Widgets/custom_textfeild.dart';
import 'package:myapp/Custom_Widgets/select_gender_radio.dart';
import 'package:myapp/Custom_Widgets/weight_diffrence.dart';
import 'package:myapp/utils/assets.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/utils/user_data.dart';

class IdealBodyWeightPage extends StatefulWidget {
  const IdealBodyWeightPage({super.key});

  @override
  State<IdealBodyWeightPage> createState() => _IdealBodyWeightPageState();
}

GlobalKey<FormState> form1 = GlobalKey<FormState>();

double idealBodyWeight = 0.0;
double currentBodyWeight = 0.0;
double heightInCentimeters = 0.0;
String gender = "Male";

class _IdealBodyWeightPageState extends State<IdealBodyWeightPage> {
  @override
  Widget build(BuildContext context) {
    var user = currentUser!;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBarr(
          "Ideal Body Weight Calculator", blueColor, backgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                key: form1,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Select Your Gender',
                        style: TextStyle(color: secondColor, fontSize: 16)),
                    CustomGenderRatio(
                      color: blueColor,
                      onGenderChanged: (value) {
                        gender = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextfeild(
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: blueColor,
                      onSaved: (value) {
                        user["height"] = double.parse(value!);
                        currentUser?["gender"] == "Male"
                            ? idealBodyWeight =
                                50 + (0.91 * (user["height"] - 152.4))
                            : idealBodyWeight =
                                45.5 + (0.91 * (user["height"] - 152.4));
                      },
                      text: "Height ",
                      validator: (value) {
                        if (idealBodyWeight < 0) {
                          return "Enter the correct data please";
                        }
                        if (value == null || value.isEmpty) {
                          return "Enter your height please";
                        }
                        return null;
                      },
                      icon: const Icon(Icons.height),
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextfeild(
                      input: FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*')),
                      isObscure: false,
                      keyboard: TextInputType.number,
                      color: blueColor,
                      onSaved: (value) {
                        user["weight"] = double.parse(value!);
                      },
                      text: "Weight ",
                      validator: (value) {
                        if (idealBodyWeight < 0) {
                          return "Enter the correct data please";
                        }
                        if (value == null || value.isEmpty) {
                          return "Enter your weight please";
                        }
                        return null;
                      },
                      icon: const Icon(Icons.monitor_weight),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomElevatedButton(
                        onpressed: () {
                          setState(() {
                            form1.currentState?.validate();
                            form1.currentState?.save();
                            idealBodyWeight =
                                (idealBodyWeight * 100).round() / 100;
                          });
                        },
                        text: "OK",
                        color: blueColor,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    idealBodyWeight > 0.0
                        ? Text(
                            " Your Ideal Body Weight is $idealBodyWeight KG",
                            style: TextStyle(color: blueColor, fontSize: 16),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    idealBodyWeight > 0
                        ? Center(
                            child: Text(
                              diffrence(user["weight"], idealBodyWeight),
                              style: TextStyle(color: blueColor, fontSize: 16),
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

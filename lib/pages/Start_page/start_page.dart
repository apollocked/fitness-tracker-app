import 'package:flutter/material.dart';
import 'package:myapp/Custom_Widgets/custom_appbar.dart';
import 'package:myapp/pages/Ideal_bodyweight_page/ideal_bw_page.dart';
import 'package:myapp/pages/Protien_intake_page/protien_intake_page.dart';
import 'package:myapp/utils/assets.dart';
import 'package:myapp/utils/colors.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBarr(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 300,
                        height: 200,
                        child: Image.asset(
                          fit: BoxFit.contain,
                          startBanner,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsetsDirectional.all(2),
                        width: 350,
                        height: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "HI !",
                              style:
                                  TextStyle(color: primaryColor, fontSize: 35),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Wellcome to Fitmesure",
                              style:
                                  TextStyle(color: primaryColor, fontSize: 25),
                            ),
                            Text(
                              "What do you wnat to know ??",
                              style:
                                  TextStyle(color: primaryColor, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: FloatingActionButton(
                          heroTag: "ideal body weight",
                          isExtended: true,
                          onPressed: () {
                            idealBodyWeight = 0.0;
                            currentBodyWeight = 0.0;
                            heightInCentimeters = 0.0;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const IdealBodyWeightPage();
                            }));
                          },
                          backgroundColor: secondColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "ideal body weight",
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: FloatingActionButton(
                          heroTag: "protien intake",
                          isExtended: true,
                          onPressed: () {
                            loweistProtienIntake = 0.0;
                            highistProtienIntake = 0.0;
                            normalProteinIntake = 0.0;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ProtienIntakePage();
                            }));
                          },
                          backgroundColor: secondColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Daily protien intake ",
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

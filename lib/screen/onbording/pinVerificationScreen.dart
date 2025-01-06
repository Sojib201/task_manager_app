import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/screen/onbording/emailVerification.dart';
import 'package:task_manager_project/style/style.dart';

import '../../api/apiClient.dart';
import '../../utility/utility.dart';

class pinVerificationScreen extends StatefulWidget {
  const pinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<pinVerificationScreen> createState() => _pinVerificationScreenState();
}

class _pinVerificationScreenState extends State<pinVerificationScreen> {
  Map<String, String> FormValues = {"otp": ""};
  bool Loading = false;

  InputOnChange(key, TextValue) {
    setState(() {
      FormValues.update(key, (value) => TextValue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['otp']!.length == 7) {
      ErrorToast("Pin Required");
    } else {
      setState(() {
        Loading = true;
      });

      String? emailAddress = await ReadUserData('EmailVerification');
      bool res = await VerifyOTPrequest(emailAddress, FormValues['otp']);

      if (res == true) {
        Navigator.pushNamed(context, "/setPassword");
      } else {
        setState(() {
          Loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            padding: EdgeInsets.all(30),
            child: Loading
                ? (Center(
                    child: CircularProgressIndicator(),
                  ))
                : (Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pin Verification",
                          style: Head1Text(colorDarkBlue),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "A 6 digit verification pin will send your email address",
                          style: Head6Text(colorLightGray),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: AppOTPStyle(),
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          onCompleted: (v) {},
                          onChanged: (TextValue) {InputOnChange("otp", TextValue);},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FormOnSubmit();
                          },
                          child: SuccessButtonChild("Verify"),
                          style: AppButtonStyle(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have account?",
                                style: Head6Text(colorDarkBlue),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Sign in",
                                style: Head6Text(colorDarkBlue),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_project/style/style.dart';
import 'package:task_manager_project/utility/utility.dart';

import '../../api/apiClient.dart';

class setPasswordScreen extends StatefulWidget {
  const setPasswordScreen({Key? key}) : super(key: key);

  @override
  State<setPasswordScreen> createState() => _setPasswordScreenState();
}

class _setPasswordScreenState extends State<setPasswordScreen> {
  Map<String, String> FormValues = {
    "email": "",
    "OTP": "",
    "password": "",
    "cpassword": ""
  };
  bool Loading = false;

  @override
  void initState() {
    CallUserData();
    super.initState();
  }

  CallUserData() async {
    String? OTP = await ReadUserData("OTPVerification");
    String? Email = await ReadUserData("EmailVerification");

    InputOnChange("email", Email);
    InputOnChange("OTP", OTP);
  }

  InputOnChange(key, TextValue) {
    setState(() {
      FormValues.update(key, (value) => TextValue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['password']!.length == 0) {
      ErrorToast("Password Required");
    } else if (FormValues['password'] != FormValues['cpassword']) {
      ErrorToast("Confirm Password Should be same");
    } else {
      setState(() {
        Loading = true;
      });

      bool res = await SetPasswordRequest(FormValues);

      if (res == true) {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Set Password",
                  style: Head1Text(colorDarkBlue),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Minimum length password 8 character with letter and number combination",
                  style: Head6Text(colorLightGray),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (TextValue) {
                    InputOnChange("password", TextValue);
                  },
                  decoration: AppInputDeceration("Password"),
                  style: Head6Text(colorDarkBlue),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (TextValue) {
                    InputOnChange("cpassword", TextValue);
                  },
                  decoration: AppInputDeceration("Confirm Password"),
                  style: Head6Text(colorDarkBlue),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    FormOnSubmit();
                  },
                  child: SuccessButtonChild("Confirm"),
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
          )
        ],
      ),
    );
  }
}

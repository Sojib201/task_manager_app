import 'package:flutter/material.dart';
import 'package:task_manager_project/style/style.dart';

import '../../api/apiClient.dart';
import '../../utility/utility.dart';

class emailVerification extends StatefulWidget {
  const emailVerification({Key? key}) : super(key: key);

  @override
  State<emailVerification> createState() => _emailVerificationState();
}

class _emailVerificationState extends State<emailVerification> {
  Map<String, String> FormValues = {"email": ""};
  bool Loading = false;

  InputOnChange(key, TextValue) {
    setState(() {
      FormValues.update(key, (value) => TextValue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['email']!.length == 0) {
      ErrorToast("Email Required");
    } else {
      setState(() {
        Loading = true;
      });

      bool res = await VerifyEmailRequest(FormValues['email']);

      if (res == true) {
        Navigator.pushNamed(context, "/pinVerification");
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Email Address",
                          style: Head1Text(colorDarkBlue),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "A 6 digit verification pin will send to your email address",
                          style: Head6Text(colorLightGray),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (TextValue) {
                            InputOnChange("email", TextValue);
                          },
                          decoration: AppInputDeceration("Email"),
                          style: Head6Text(colorDarkBlue),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FormOnSubmit();
                          },
                          style: AppButtonStyle(),
                          child: SuccessButtonChild("Next"),
                        ),
                      ],
                    ),
                  )),
          ),
        ],
      ),
    );
  }
}

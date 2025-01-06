import 'package:flutter/material.dart';
import 'package:task_manager_project/style/style.dart';

import '../../api/apiClient.dart';

class registrationScreen extends StatefulWidget {
  const registrationScreen({Key? key}) : super(key: key);

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {
  Map<String, String> FormValues = {
    "email": "",
    "firstName": "",
    "lastName": "",
    "mobile": "",
    "password": "",
    "photo": "",
    "cPassword": "",
  };
  bool Loading = false;

  InputOnChange(key, TextValue) {
    setState(() {
      FormValues.update(key, (value) => TextValue);
    });
  }

  FormOnSubmit() async {
    if (FormValues["email"]!.length == 0) {
      ErrorToast("Email Required");
    } else if (FormValues["firstName"]!.length == 0) {
      ErrorToast("First Name Required");
    } else if (FormValues["lastName"]!.length == 0) {
      ErrorToast("Last Name Required");
    } else if (FormValues["mobile"]!.length == 0) {
      ErrorToast("Mobile Number Required");
    } else if (FormValues["password"]!.length == 0) {
      ErrorToast("Password Required");
    } else if (FormValues["password"] != FormValues["cPassword"]) {
      ErrorToast("Confirm Password should be same");
    } else {
      setState(() {
        Loading = true;
      });
      bool res = await RegistrationRequest(FormValues);

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
      body: SingleChildScrollView(
        child: Stack(
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
                            "Join With Us",
                            style: Head1Text(colorDarkBlue),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (TextValue) {
                              InputOnChange("email", TextValue);
                            },
                            decoration: AppInputDeceration("Email"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (TextValue) {
                              InputOnChange("firstName", TextValue);
                            },
                            decoration: AppInputDeceration("First Name"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (TextValue) {
                              InputOnChange("lastName", TextValue);
                            },
                            decoration: AppInputDeceration("Last Name"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (TextValue) {
                              InputOnChange("mobile", TextValue);
                            },
                            decoration: AppInputDeceration("Mobile"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (TextValue) {
                              InputOnChange("password", TextValue);
                            },
                            decoration: AppInputDeceration("Password"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (TextValue) {
                              InputOnChange("cPassword", TextValue);
                            },
                            decoration: AppInputDeceration("Confirm Password"),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FormOnSubmit();
                            },
                            child: SuccessButtonChild("Registration"),
                            style: AppButtonStyle(),
                          ),
                        ],
                      ),
                    )),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../api/apiClient.dart';
import '../../style/style.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  Map<String, String> FormValues = {"email": "", "password": ""};
  bool Loading = false;

  InputOnChange(key, TextValue) {
    setState(() {
      FormValues.update(key, (value) => TextValue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['email']!.length == 0) {
      ErrorToast("Email Required");
    } else if (FormValues['password']!.length == 0) {
      ErrorToast("Password Required");
    } else {
      setState(() {
        Loading = true;
      });

      bool res = await LoginRequest(FormValues);

      if (res == true) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/", (route) => false);
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
            child: Loading
                ? (Center(
                    child: CircularProgressIndicator(),
                  ))
                : (Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get Started With",
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
                            InputOnChange("password", TextValue);
                          },
                          decoration: AppInputDeceration("Password"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FormOnSubmit();
                          },
                          child: SuccessButtonChild("Login"),
                          style: AppButtonStyle(),
                        ),
                        SizedBox(height: 30,),
                        Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/emailVerification");
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: HeadText7(colorLightGray),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/registration");
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have a account?",
                                        style: HeadText7(colorDarkBlue),
                                      ),
                                      Text(
                                        "Sign Up",
                                        style: HeadText7(colorGreen),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  )),
          ),
        ],
      ),
    );
  }
}

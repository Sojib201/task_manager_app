import 'package:flutter/material.dart';
import 'package:task_manager_project/screen/onbording/emailVerification.dart';
import 'package:task_manager_project/screen/onbording/loginScreen.dart';
import 'package:task_manager_project/screen/onbording/pinVerificationScreen.dart';
import 'package:task_manager_project/screen/onbording/registrationScreen.dart';
import 'package:task_manager_project/screen/onbording/setPasswordScreen.dart';
import 'package:task_manager_project/screen/task/homescreen.dart';
import 'package:task_manager_project/screen/task/taskCreateScreen.dart';
import 'package:task_manager_project/utility/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await ReadUserData("token");

  if (token == null) {
    runApp(MyApp("/login"));
  } else {
    runApp(MyApp("/"));
  }
}

class MyApp extends StatelessWidget {
  final String FirstRoute;
  MyApp(this.FirstRoute);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      initialRoute: FirstRoute,
      routes: {
        '/': (context) => homeScreen(),
        '/login': (context) => loginScreen(),
        '/registration': (context) => registrationScreen(),
        '/emailVerification': (context) => emailVerification(),
        '/pinVerification': (context) => pinVerificationScreen(),
        '/setPassword': (context) => setPasswordScreen(),
        '/taskCreate': (context)=> taskCreateScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_project/component/appBottomNav.dart';
import 'package:task_manager_project/component/cancelTaskList.dart';
import 'package:task_manager_project/component/completedTaskList.dart';
import 'package:task_manager_project/component/newTaskList.dart';
import 'package:task_manager_project/component/progressTaskList.dart';
import 'package:task_manager_project/utility/utility.dart';

import '../../component/TaskAppbar.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  Map<String, String> ProfileData = {
    "email": "",
    "firstName": "",
    "lastName": "",
    "photo": DeafultImage,
  };

  // ReadAppBarData() async {
  //   String? email = await ReadUserData('email');
  //   String? firstName = await ReadUserData('firstName');
  //   String? lastName = await ReadUserData('lastName');
  //   String? photo = await ReadUserData('photo');
  //   setState(() {
  //     ProfileData = {
  //       "email": '$email',
  //       "firstName": '$firstName',
  //       "lastName": '$lastName',
  //       "photo": '$photo',
  //     };
  //   });
  // }

  // @override
  // void initState() {
  //   ReadAppBarData();
  //   super.initState();
  // }

  int TabIndex = 0;

  onItemTapped(int index) {
    setState(() {
      TabIndex = index;
    });
  }

  final widgetOption = [
    newTaskList(),
    progressTaskList(),
    completedTaskList(),
    cancelTaskList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskAppBar(context, ProfileData),
      body: widgetOption.elementAt(TabIndex),
      bottomNavigationBar: appBottomNav(TabIndex, onItemTapped),
    );
  }
}

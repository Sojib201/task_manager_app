import 'package:flutter/material.dart';
import 'package:task_manager_project/style/style.dart';
import 'package:task_manager_project/utility/utility.dart';

AppBar TaskAppBar(context, ProfileData) {
  return AppBar(
    backgroundColor: colorGreen,
    flexibleSpace: Container(
      margin: EdgeInsets.fromLTRB(10, 40, 10, 3),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 24,
            child: ClipOval(
              child: Image.memory(ShowBase64Image(ProfileData['photo'])),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // '${ProfileData['firstName']} ${ProfileData['lastName']}',
                "Sojib",
                style: HeadText7(colorWhite),
              ),
              Text(
                // ProfileData['email'],
                "sojib.cse3729@gmail.com",
                style: HeadText9(colorWhite),
              ),
            ],
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/taskCreate');
        },
        icon: Icon(Icons.add_circle_outline),
      ),
      IconButton(
          onPressed: () {
            RemoveToken();
            Navigator.pushNamedAndRemoveUntil(
                context, "/login", (route) => false);
          },
          icon: Icon(Icons.output))
    ],
  );
}

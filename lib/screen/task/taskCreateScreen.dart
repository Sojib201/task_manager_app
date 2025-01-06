import 'package:flutter/material.dart';
import 'package:task_manager_project/style/style.dart';

import '../../api/apiClient.dart';

class taskCreateScreen extends StatefulWidget {
  const taskCreateScreen({Key? key}) : super(key: key);

  @override
  State<taskCreateScreen> createState() => _taskCreateScreenState();
}

class _taskCreateScreenState extends State<taskCreateScreen> {
  Map<String, String> FormValues = {
    "title": "",
    "description": "",
    "status": "New"
  };
  bool Loading = false;

  InputOnChange(key, TextValue) {
    setState(() {
      FormValues.update(key, (value) => TextValue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['title']!.length == 0) {
      ErrorToast("Title Required");
    } else if (FormValues['description']!.length == 0) {
      ErrorToast("Description Required");
    } else {
      setState(() {
        Loading = true;
      });

      bool res = await TaskCreateRequest(FormValues);

      if (res == true) {
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
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
      appBar: AppBar(
        title: Text("Create New Task"),
        backgroundColor: colorGreen,
      ),
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add New Task",
                            style: Head1Text(colorDarkBlue),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (TextValue) {
                              InputOnChange("title", TextValue);
                            },
                            decoration: AppInputDeceration("Task Name"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (TextValue) {
                              InputOnChange("description", TextValue);
                            },
                            maxLines: 8,
                            decoration: AppInputDeceration("Description"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FormOnSubmit();
                            },
                            child: SuccessButtonChild("Create"),
                            style: AppButtonStyle(),
                          ),
                        ],
                      ),
                    ),
                  )),
          ),
        ],
      ),
    );
  }
}

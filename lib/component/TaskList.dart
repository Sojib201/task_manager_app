import 'package:flutter/material.dart';
import 'package:task_manager_project/style/style.dart';

ListView TaskList(TaskItem,DeleteItem,StatusChange) {
  return ListView.builder(
    itemCount: TaskItem.length,
    itemBuilder: (context, index) {
      Color statusColor=colorGreen;
      if(TaskItem[index]['status']=="New"){
        statusColor=colorBlue;
      }
      else if(TaskItem[index]['status']=="Progress"){
        statusColor=colorOrange;
      }
      else if(TaskItem[index]['status']=="Canceled"){
        statusColor=colorRed;
      }

      return Card(
        child: ItemSizeBox(
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TaskItem[index]['title'],
                style: Head6Text(colorDarkBlue),
              ),
              Text(
                TaskItem[index]['description'],
                style: HeadText7(colorLightGray),
              ),
              Text(TaskItem[index]['createdDate'],style: HeadText9(colorDarkBlue),),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusChild(TaskItem[index]['status'],statusColor),
                  Container(
                      child: Row(
                        children: [
                          SizedBox(width: 50,height:30,child:ElevatedButton(onPressed:(){
                            StatusChange(TaskItem[index]['_id']);
                          },child: Icon(Icons.edit_location_alt_outlined,size: 16),style:AppStatusButtonStyle(colorBlue))),


                          SizedBox(width: 10),

                          SizedBox(width: 50,height: 30,child: ElevatedButton( onPressed:(){
                            DeleteItem(TaskItem[index]['_id']);
                          }, child: Icon(Icons.delete_outlined,size: 16),style:AppStatusButtonStyle(colorRed)))
                        ],
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

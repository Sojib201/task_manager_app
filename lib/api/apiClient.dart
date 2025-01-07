import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_project/style/style.dart';
import 'package:task_manager_project/utility/utility.dart';

var BaseURL = "https://task.teamrabbil.com/api/v1";
var RequestHeader = {"Content-Type": "application/json"};

Future<bool> LoginRequest(FromValues) async  {
  var URL = Uri.parse("${BaseURL}/login");
  var PostBody = json.encode(FromValues);

  var Response = await http.post(URL, headers: RequestHeader, body: PostBody);

  var ResultCode = Response.statusCode;
  var ResultBody = json.decode(Response.body);

  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast("Request Success");
    WriteUserData(ResultBody);
    return true;
  } else {
    ErrorToast("Request Failed ! Try agrain");
    return false;
  }
}

Future<bool> RegistrationRequest(FormValues) async {
  var URL = Uri.parse("${BaseURL}/registration");
  var PostBody = json.encode(FormValues);

  var Response = await http.post(URL, headers: RequestHeader, body: PostBody);

  var ResultCode = Response.statusCode;
  var ResultBody = json.decode(Response.body);

  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request Failed ! Try agrain");
    return false;
  }
}

Future<bool> VerifyEmailRequest(Email) async{
  var URL = Uri.parse("${BaseURL}/RecoverVerifyEmail/${Email}");
  var Response = await http.get(URL,headers: RequestHeader);

  var ResultCode= Response.statusCode;
  var ResultBody= json.decode(Response.body);

  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    await WriteEmailVerification(Email);
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request Failed ! Try agrain");
    return false;
  }

}

Future<bool> VerifyOTPrequest(Email, OTP) async{
  var URL=Uri.parse("${BaseURL}/RecoverVerifyOTP/${Email}/${OTP}");
  var Response = await http.get(URL,headers: RequestHeader);

  var ResultCode=Response.statusCode;
  var ResultBody=json.decode(Response.body);

  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    await WriteOTPVerification(OTP);
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request Failed ! Try agrain");
    return false;
  }

}

Future<bool> SetPasswordRequest(FormValues)async{
  var URL=Uri.parse("${BaseURL}/RecoverResetPass");
  var PostBody=json.encode(FormValues);

  var Response = await http.post(URL,headers: RequestHeader, body: PostBody);

  var ResultCode= Response.statusCode;
  var ResultBody=json.decode(Response.body);

  if (ResultCode == 200 && ResultBody['status'] == 'success') {
    SuccessToast("Request Success");
    return true;
  } else {
    ErrorToast("Request Failed ! Try agrain");
    return false;
  }

}

Future<List> TaskListRequest(Status) async {
  var URL=Uri.parse("${BaseURL}/listTaskByStatus/${Status}");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
  var Response= await http.get(URL,headers:RequestHeaderWithToken);
  var ResultCode=Response.statusCode;
  var ResultBody=json.decode(Response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    print(ResultBody['data']);
    return ResultBody['data'];
  }
  else{
    ErrorToast("Request fail ! try again");
    return [];
  }
}

Future<bool> TaskCreateRequest(FormValues) async {
  var URL=Uri.parse("${BaseURL}/createTask");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};

  var PostBody = json.encode(FormValues);

  var Response= await http.post(URL,headers:RequestHeaderWithToken,body: PostBody);
  var ResultCode=Response.statusCode;
  var ResultBody=json.decode(Response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<void> TaskDeleteRequest(id) async {
  var URL=Uri.parse("${BaseURL}/deleteTask/${id}");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
  var Response= await http.get(URL,headers:RequestHeaderWithToken);
  var ResultCode=Response.statusCode;
  var ResultBody=json.decode(Response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");



  }
  else{
    ErrorToast("Request fail ! try again");

  }
}

Future<List> TaskUpdateRequest(id,status) async {
  var URL=Uri.parse("${BaseURL}/updateTaskStatus/${id}/${status}");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
  var Response= await http.get(URL,headers:RequestHeaderWithToken);
  var ResultCode=Response.statusCode;
  var ResultBody=json.decode(Response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return ResultBody['data'];
  }
  else{
    ErrorToast("Request fail ! try again");
    return [];
  }
}



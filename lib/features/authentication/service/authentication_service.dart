// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:amazon_clone/common/widgets/service_error_handling.dart';
import 'package:amazon_clone/common/widgets/utility.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constant_keys.dart';

final authServiceProvider = Provider((ref) {
  return AuthService();
});

class AuthService {
  UserModel currentUser = UserModel();
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String fullname,
    required String phone,
  }) async {
    try {
      Map<String, dynamic> user = {
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "password": password,
      };
      http.Response response = await http.post(
        Uri.parse("$myip/api/user/createaccount"),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'UTF-8',
        },
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccessMessage:
              'SignUp Successfull.Now, Login with same credentials.!!',
          onfailureMessage:
              'SignUp Failed !! There exists a user with same credentials.');
    } on Exception catch (e) {
      log(e.toString());

      showSnackBar(context, e.toString());
    }
  }

  Future<UserModel> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> user = {
        "email": email,
        "password": password,
      };
      http.Response response = await http.post(
        Uri.parse("$myip/api/user/login"),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'UTF-8',
        },
      );
      var recvdata = jsonDecode(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          currentUser = UserModel.fromJson(recvdata['data']);
          showSnackBar(context, 'Successfully LoggedIn !!');
          SharedPreferences sp = await SharedPreferences.getInstance();
          await sp.setString('x-auth-token', currentUser.token ?? '');
          await sp.setString('user-id', currentUser.userid ?? '');
        },
        onfailure: () {
          currentUser.userid = null;
        },
      );
    } on Exception catch (e) {
      log(e.toString());

      showSnackBar(context, e.toString());
    }
    return currentUser;
  }

  Future<UserModel?> getUserDetails() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userid = sp.getString('user-id')!;
      http.Response response = await http.get(
        Uri.parse('$myip/api/user/$userid'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'UTF-8',
          'auth-token': '${sp.getString('x-auth-token')}',
          'user-id': '${sp.getString('user-id')}',
        },
      );
      var recvdata = await jsonDecode(response.body);
      httpErrorHandle(
        response: response,
        onSuccess: () {
          currentUser = UserModel.fromJson(recvdata['data']);
        },
        onfailure: () {
          currentUser.userid = null;
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
    log(currentUser.userid.toString());
    return currentUser;
  }
}

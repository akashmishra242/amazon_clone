import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../common/widgets/service_error_handling.dart';
import '../../../common/widgets/utility.dart';
import '../../../constants/constant_keys.dart';
import '../../../models/user_model.dart';
import '../../authentication/service/authentication_service.dart';

final homePageControllerProvider = Provider(
  (ref) {
    return HomePageController(ref: ref);
  },
);

class HomePageController {
  final ProviderRef ref;
  HomePageController({
    required this.ref,
  });

  Future<String> updatePassword({
    required BuildContext context,
    String? password,
    String? oldpassword,
    String? confirmnewpassword,
  }) async {
    String output = '';
    try {
      UserModel? userdata =
          await ref.read(authServiceProvider).getUserDetails();

      Map<String, String> userPassword = {'password': password ?? ''};
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userid = sp.getString('user-id') ?? userdata?.userid ?? '';
      http.Response response = await http.put(
        Uri.parse("$myip/api/user/updatepassword/$userid"),
        body: jsonEncode(userPassword),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'UTF-8',
          'userid': userid,
          'old-password': oldpassword ?? '',
          'confirm-new-password': confirmnewpassword ?? ''
        },
      );

      output = httpErrorHandle(
          context: context,
          response: response,
          onSuccessMessage: 'Password Updated Successfully');
    } on Exception catch (e) {
      log(e.toString());
      showSnackBar(context, e.toString());
    }
    return output;
  }

  Future<String> updateUserData({
    required BuildContext context,
    String? fullname,
    String? email,
    String? phone,
    String? address,
    String? country,
    String? city,
    String? pincode,
  }) async {
    String output = '';
    try {
      UserModel? userdata =
          await ref.read(authServiceProvider).getUserDetails();

      Map<String, String> user = {
        'fullname': fullname ?? '',
        'email': email ?? '',
        'phone': phone ?? '',
        'address': address ?? userdata?.address ?? '',
        'country': country ?? userdata?.country ?? '',
        'city': city ?? userdata?.city ?? '',
        'pincode': pincode ?? userdata?.pincode ?? '',
      };
      SharedPreferences sp = await SharedPreferences.getInstance();
      String userid = sp.getString('user-id') ?? userdata?.userid ?? '';
      http.Response response = await http.put(
        Uri.parse("$myip/api/user/$userid"),
        body: jsonEncode(user),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'UTF-8',
          'userid': userid
        },
      );

      output = httpErrorHandle(
          context: context,
          response: response,
          onSuccessMessage: 'Profile Updated Successsfully');
    } on Exception catch (e) {
      showSnackBar(context, e.toString());
    }
    return output;
  }

  Future<String> getUserAddress({required BuildContext context}) async {
    String output = '';
    try {
      UserModel? user = await ref.read(authServiceProvider).getUserDetails();
      if (user!.fullname == null || user.fullname == '') {
        output = 'require login !!';
        return output;
      }
      output =
          'Deliver to ${user.fullname?.split(' ')[0]} - ${user.city} ${user.pincode}';
    } on Exception catch (e) {
      log(e.toString());
    }

    return output;
  }
}

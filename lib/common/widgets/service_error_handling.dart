import 'dart:convert';
import 'package:amazon_clone/common/widgets/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String httpErrorHandle({
  required http.Response response,
  BuildContext? context,
  VoidCallback? onSuccess,
  VoidCallback? onfailure,
  String? onSuccessMessage,
  String? onfailureMessage,
}) {
  String output = '';
  var recvdata = jsonDecode(response.body);
  switch (response.statusCode) {
    case 200:
      {
        if (recvdata['success'].toString() == 'true') {
          if (onSuccess == null) {
            showSnackBar(context!, onSuccessMessage ?? 'Task Successfull');
          } else {
            onSuccess();
          }
        } else {
          if (onfailure == null) {
            output = recvdata['error'].toString();
            showSnackBar(
                context!, onfailureMessage ?? recvdata['error'].toString());
          } else {
            onfailure();
            showSnackBar(
                context!, onfailureMessage ?? recvdata['error'].toString());
            output = recvdata['error'].toString();
          }
        }

        break;
      }
    default:
      {
        if (onfailure == null) {
          showSnackBar(context!, 'Error: ${response.statusCode.toString()}');
        } else {
          onfailure();
        }

        break;
      }
  }
  return output;
}

import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 12,
          color: GlobalVariables.secondaryColor,
        ),
      ),
    );
  }
}

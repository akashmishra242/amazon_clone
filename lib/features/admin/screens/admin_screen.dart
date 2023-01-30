import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/admin/widgets/custom_container_button.dart';
import 'package:amazon_clone/features/admin/widgets/keepshoping.dart';
import 'package:amazon_clone/features/admin/widgets/orders.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_app_constants.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = '/Admin-screen';
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        backgroundColor: GlobalVariables.backgroundColor,
        child: Image.asset(
          'assets/images/alexa_icon.png',
          scale: 1.25,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            constraints: const BoxConstraints(
                maxWidth: kMinInteractiveDimension, minWidth: 42),
            onPressed: () {},
            icon: Badge(child: const Icon(Icons.notifications, size: 30)),
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
          ),
          IconButton(
            constraints: const BoxConstraints(
                maxWidth: kMinInteractiveDimension, minWidth: 42),
            onPressed: () {},
            icon: const Icon(Icons.search, size: 30),
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
          ),
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.otherAppBarGradient,
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned(
                  left: 0,
                  child: Image.asset(
                    'assets/images/mylogo_wbg.png',
                    scale: 5.5,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.072,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: GlobalVariables.otherAppBarGradient,
              ),
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Positioned(
                    left: 5,
                    top: 12,
                    child: RichText(
                      text: TextSpan(
                        text: 'Hello, ',
                        style: TextStyle(
                            fontSize: 28, color: textTheme.headline6!.color),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Admin',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: CircleAvatar(
                        radius: size.width / 14,
                        backgroundColor: GlobalVariables.greyBackgroundCOlor,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 55,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.15,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Positioned(
                    left: 10,
                    top: 10,
                    child: CustomContainerButton(
                        cnxt: context, text: 'Your Orders'),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child:
                        CustomContainerButton(cnxt: context, text: 'Buy Again'),
                  ),
                  Positioned(
                    left: 10,
                    top: 65,
                    child: CustomContainerButton(
                        cnxt: context, text: 'Your Account'),
                  ),
                  Positioned(
                    right: 10,
                    top: 65,
                    child: CustomContainerButton(
                        cnxt: context, text: 'Your Wish List'),
                  ),
                ],
              ),
            ),
            const Orders(),
            const KeepShoping(),
          ],
        ),
      ),
    );
  }
}

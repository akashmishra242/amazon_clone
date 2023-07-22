import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/global_app_constants.dart';

class CustomCards extends StatefulWidget {
  final Widget? child;
  final int? index;
  const CustomCards({
    Key? key,
    this.child,
    this.index,
  }) : super(key: key);

  @override
  State<CustomCards> createState() => _CustomCardsState();
}

class _CustomCardsState extends State<CustomCards> {
  var list = GlobalVariables.carouselImages.map((e) => Builder(
        builder: (context) => Image.network(
          e,
          fit: BoxFit.cover,
        ),
      ));

  var list2 = GlobalVariables.cardWidgetsForHomeScreen.map((e) => e);
  // var list2 = GlobalVariables.categoryImages.map((e) => e);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      elevation: 5,
      color: GlobalVariables.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Container(
        height: size.height * 0.18,
        width: size.width * 0.38,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: GlobalVariables.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: list2.elementAt(widget.index!),
        // child: list.elementAt(widget.index!),
        // child: const Icon(Icons.textsms_outlined),
      ),
    );
  }
}
// 
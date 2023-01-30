import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowPromotions extends StatelessWidget {
  const ShowPromotions({super.key});

  @override
  Widget build(BuildContext context) {
    var list = GlobalVariables.carouselImages
        .map((e) => Builder(
              builder: (context) => Image.network(
                e,
                fit: BoxFit.contain,
              ),
            ))
        .toList();
    return ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        //scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 8, top: 0),
        itemBuilder: (context, index) {
          return list.elementAt(index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 5,
          );
        },
        itemCount: GlobalVariables.carouselImages.length);
  }
}

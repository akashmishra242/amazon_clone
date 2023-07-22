import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:flutter/material.dart';

class CategoryHomePageItems extends StatelessWidget {
  const CategoryHomePageItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Map<String, String> item =
              GlobalVariables.categoryImages.elementAt(index);
          String title = item['title']!;
          String imageurl = item['image']!;

          return Container(
            padding: const EdgeInsets.only(top: 3),
            margin: const EdgeInsets.only(left: 3, right: 3),
            width: MediaQuery.of(context).size.width / 5,
            decoration: const BoxDecoration(
                color: GlobalVariables.backgroundColor,
                //border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 25,
                  onBackgroundImageError: (exception, stackTrace) {
                    const CircularProgressIndicator();
                  },
                  backgroundImage: Image.asset(
                    imageurl,
                    // 'assets/images/alexa_icon.png',
                    fit: BoxFit.cover,
                  ).image,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

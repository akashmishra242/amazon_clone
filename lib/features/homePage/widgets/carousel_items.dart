import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  final CarouselController _controller = CarouselController();
  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        CarouselSlider(
          items: GlobalVariables.carouselImages
              .map((e) => Builder(
                    builder: (context) => Image.network(
                      e,
                      fit: BoxFit.cover,
                    ),
                  ))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              currentpage = index;
              setState(() {});
            },
            height: 210,
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlay: true,
          ),
        ),
        //!
        Positioned(
          bottom: 8,
          child: SizedBox(
            height: 20,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: GlobalVariables.carouselImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Radio(
                      activeColor: GlobalVariables.selectedNavBarColor,
                      value: index,
                      groupValue: currentpage,
                      onChanged: (value) {
                        _controller.animateToPage(value!,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                        setState(() {});
                      });
                }),
          ),
        ),
      ],
    );
  }
}

import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:amazon_clone/features/authentication/controller/auth_controller.dart';
import 'package:amazon_clone/features/homePage/controller/home_page_controller.dart';
import 'package:amazon_clone/features/homePage/screen/edituser.dart';
import 'package:amazon_clone/features/homePage/widgets/cards.dart';
import 'package:amazon_clone/features/homePage/widgets/carousel_items.dart';
import 'package:amazon_clone/features/homePage/widgets/category_items.dart';
import 'package:amazon_clone/features/homePage/widgets/show_promotions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/show_popupmenu.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool showLinearProgessIndicator = true;
  String addressDisplayText = '';

  void logout() {
    ref.read(authControllerProvider).logout(context: context);
  }

  void getUserAddress() async {
    addressDisplayText = await ref
        .read(homePageControllerProvider)
        .getUserAddress(context: context);
    setState(() {});
  }

  Widget showPopupMenu() {
    return ShowPopupMenu(
      context: context,
      passwidgetandOnTapMap: {
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditUserDetails(),
                  ));
            },
            icon: const Icon(Icons.edit)): () {},
        IconButton(onPressed: () => logout(), icon: const Icon(Icons.logout)):
            () {},
      },
    );
  }

  void showProgessIndicator() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    setState(() {
      showLinearProgessIndicator = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserAddress();
    showProgessIndicator();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            constraints: const BoxConstraints(
              maxWidth: kMinInteractiveDimension / 2.5,
            ),
            onPressed: () {},
            icon: const Icon(Icons.mic, size: 30),
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
          ),
          showPopupMenu(),
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width * 0.025,
                bottom: MediaQuery.of(context).size.height * 0.08 * 0.14,
                child: Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08 * 0.65,
                    width: MediaQuery.of(context).size.width * 0.78,
                    decoration: BoxDecoration(
                      color: GlobalVariables.backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(
                          color: Colors.grey.shade300,
                          strokeAlign: StrokeAlign.inside),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Codexveer.com',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const ImageIcon(
                                AssetImage('assets/images/lens.png')),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! Linear Progerss Indication
            showLinearProgessIndicator
                ? const LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  )
                : SizedBox(
                    height: 5,
                    width: double.infinity,
                    child: Container(
                        color: const Color.fromARGB(255, 181, 207, 207)),
                  ),
            //! show address of the user
            Material(
              elevation: 5,
              child: Container(
                height: size.height * 0.05,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 125, 221, 216)),
                child: Row(children: [
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.location_on_outlined,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(addressDisplayText),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 30,
                      )),
                ]),
              ),
            ), //!show category items
            const SizedBox(
              height: 5,
            ),
            //! show top catehory items
            const CategoryHomePageItems(),
            //! show corasuel Image
            const SizedBox(
              height: 5,
            ),
            const CarouselImage(),
            //! show cards
            SizedBox(
              height: size.height * 0.19,
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 8, top: 5),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomCards(index: index);
                  },
                  itemCount: GlobalVariables.cardWidgetsForHomeScreen.length,
                  scrollDirection: Axis.horizontal),
            ),
            //!show promotions
            const ShowPromotions(),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Alexa'),
          icon: Image.asset(
            'assets/images/alexa_icon.png',
          ),
          backgroundColor: GlobalVariables.backgroundColor),
    );
  }
}

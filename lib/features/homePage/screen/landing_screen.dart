import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:badges/badges.dart' as bg;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/global_app_constants.dart';
import 'home_screen.dart';

class LandingScreen extends ConsumerStatefulWidget {
  static const routeName = '/Landing-screen';
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  int _page = 0;
  var bottomBarWidth = 42.0;
  var bottomBarBorderWidth = 5.0;
  var bottombarheight = 42.0;

  List<Widget> bottomNavigatonBarPages = [
    const HomeScreen(),
    const AdminScreen(),
    const Text('refresh'),
    const Text('cart'),
    const Text('more')
  ];
  updatePage(int value) {
    _page = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavigatonBarPages[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        currentIndex: _page,
        iconSize: 28,
        elevation: 8,
        enableFeedback: true,
        backgroundColor: GlobalVariables.backgroundColor,
        onTap: (value) => updatePage(value),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              height: bottombarheight,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(Icons.home,
                  color: _page == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: bottombarheight,
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(Icons.person_outline_sharp,
                  color: _page == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: bottombarheight,
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(Icons.sync,
                  color: _page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: bottombarheight,
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 3
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: bg.Badge(
                badgeContent: const Text(
                  '0',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                badgeColor: GlobalVariables.backgroundColor,
                elevation: 0,
                child: Icon(Icons.shopping_cart_outlined,
                    color: _page == 3
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.unselectedNavBarColor),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: bottombarheight,
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 4
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(Icons.menu,
                  color: _page == 4
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

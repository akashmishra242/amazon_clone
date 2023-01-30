import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:flutter/material.dart';

class ShowPopupMenu extends StatelessWidget {
  final BuildContext context;
  final Map<Widget, VoidCallback> passwidgetandOnTapMap;
  const ShowPopupMenu(
      {super.key, required this.context, required this.passwidgetandOnTapMap});

  @override
  Widget build(BuildContext context) {
    Map<Widget, VoidCallback> menuItems = passwidgetandOnTapMap;

    final List<PopupMenuItem<Widget>> popUpMenuItems = menuItems.entries
        .map((e) => PopupMenuItem(
              value: e.key,
              onTap: () => e.value,
              child: e.key,
            ))
        .toList();

    return PopupMenuButton<Widget>(
      iconSize: 30,
      color: GlobalVariables.greyBackgroundCOlor,
      enableFeedback: true,
      itemBuilder: (BuildContext context) => popUpMenuItems,
    );
  }
}

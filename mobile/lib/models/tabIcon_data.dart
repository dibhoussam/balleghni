import 'package:flutter/material.dart';

//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
class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });
  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;
  AnimationController? animationController;
  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      // imagePath: 'assets/Icon/tablighatnocolor.png',
      imagePath: 'assets/Icon/1.png',
      //imagePath: 'assets/fitness_app/tab_1.png',
      selectedImagePath: 'assets/Icon/1C.png',
      //selectedImagePath: 'assets/Icon/tablighatcolor.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/Icon/2.png',
      selectedImagePath: 'assets/Icon/2C.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/Icon/3.png',
      selectedImagePath: 'assets/Icon/3C.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/Icon/4.png',
      selectedImagePath: 'assets/Icon/4C.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}

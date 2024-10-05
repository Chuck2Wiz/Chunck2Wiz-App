
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../define/color_defines.dart';
import '../../define/font_defines.dart';

class BottomNavigationWidget extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onClickItem;
  final int selectedItemIndex;

  const BottomNavigationWidget({
    super.key,
    required this.items,
    required this.onClickItem,
    this.selectedItemIndex = 0
  });

  @override
  State<StatefulWidget> createState() => _BottomNavigationWidget();
}

class _BottomNavigationWidget extends State<BottomNavigationWidget> {
  int _selectedItemIndex = 0;
  double _height = 83;
  Offset _iconOffset = const Offset(0, 0);

  @override
  void initState() {
    if (kIsWeb) {
      _height = 66;
      _iconOffset = const Offset(0, -1);
    } else {
      if (Platform.isIOS) {
        _height = 83;
        _iconOffset = const Offset(0, -5);
      } else {
        _height = 66;
        _iconOffset = const Offset(0, -1);
      }
    }
    super.initState();
  }

  final List<String> activeImage = [
    'assets/images/ic_bottom_home_active.png',
    'assets/images/ic_bottom_ai_deactivate.png',
    'assets/images/ic_bottom_community_active.png',
    'assets/images/ic_bottom_my_page_active.png'
  ];

  final List<String> deactiviateImage = [
    'assets/images/ic_bottom_home_deactivate.png',
    'assets/images/ic_bottom_ai_deactivate.png',
    'assets/images/ic_bottom_community_deactivate.png',
    'assets/images/ic_bottom_my_page_deactivate.png'
  ];

  final List<String> itemName = [
    '홈', 'AI 분석', '커뮤니티', '마이페이지'
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: _height,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 3),
                  blurRadius: 4,
                  spreadRadius: 4
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.items.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Transform.translate(
                              offset: _iconOffset,
                              child: SizedBox(
                                width: 28,
                                height: 28,
                                child: _selectedItemIndex == index
                                    ? Image.asset(activeImage[index], fit: BoxFit.contain, color: ColorDefines.mainColor)
                                    : Image.asset(deactiviateImage[index], fit: BoxFit.contain, color: ColorDefines.primaryGray),
                              ),
                            ),
                            Text(
                              itemName[index],
                              style: _selectedItemIndex == index
                                  ? FontDefines.bottomBarActive
                                  : FontDefines.bottomBarDeactivate,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedItemIndex = index;
                            });
                            widget.onClickItem(item);
                          },
                          child: Container(
                            color: Colors.transparent,
                            height: _height,
                            width: (constraints.maxWidth - 40) / 4,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }
    );
  }

}
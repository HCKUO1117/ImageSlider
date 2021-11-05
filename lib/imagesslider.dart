import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imageslider/indicator.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imagePaths;
  final double height;
  final Color dotSelectedColor;
  final Color dotColor;
  final double selectOpacity;
  final double unSelectedOpacity;
  final double dotSize;
  final double dotPadding;
  final bool? auto;
  final int? speed;

  const ImageSlider({
    Key? key,
    required this.imagePaths,
    required this.height,
    required this.dotSelectedColor,
    required this.dotColor,
    required this.selectOpacity,
    required this.unSelectedOpacity,
    required this.dotSize,
    required this.dotPadding,
    this.auto,
    this.speed,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  ///目前slider位置
  int currentIndex = 0;

  ///實際的位置
  ///設置1000確保可以往左滑
  int actualIndex = 1000;

  ///控制pageView位置
  ///initialPage : 初始位置與actualIndex相同
  PageController pageController = PageController(initialPage: 1000);

  @override
  void initState() {
    ///計時器
    if(widget.auto ?? false){
      startTimer();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ///imageSlider上方圖片
          Container(
            child: _getPageView(),
          ),

          ///下方點
          Positioned(
            child: _getIndicator(),
            left: 0,
            bottom: 0,
            right: 0,
          )
        ],
      ),
      height: widget.height,
    );
  }

  ///建立下方點
  Widget _getIndicator() {
    return Indicator(
      currentIndex: currentIndex,
      dotCount: widget.imagePaths.length,
      onItemTap: (index) {
        pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      },
      dotColor: widget.dotColor,
      dotSelectedColor: widget.dotSelectedColor,
      dotSize: widget.dotSize,
      dotPadding: widget.dotPadding,
      selectOpacity: widget.selectOpacity,
      unSelectedOpacity: widget.unSelectedOpacity,
      actualIndex: actualIndex,
    );
  }

  ///建立imageSlider畫面
  _getPageView() {
    return PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Image(
          image:
              AssetImage(widget.imagePaths[index % widget.imagePaths.length]),
          fit: BoxFit.cover,
        );
      },
      onPageChanged: (index) {
        setState(() {
          currentIndex = index % widget.imagePaths.length;
          actualIndex = index;
        });
      },
      controller: pageController,
    );
  }

  void startTimer() {
    ///設定間隔時間
    Timer.periodic(Duration(milliseconds: widget.speed ?? 3000), (value) {
      print("$currentIndex");

      actualIndex++;

      ///觸發輪播切換
      pageController.animateToPage(actualIndex,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }
}

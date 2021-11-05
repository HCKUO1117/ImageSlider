import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int currentIndex;
  final int dotCount;
  final ValueChanged onItemTap;
  final Color dotColor;
  final Color dotSelectedColor;
  final double dotSize;
  final double dotPadding;
  final double selectOpacity;
  final double unSelectedOpacity;
  final int actualIndex;

  Indicator({
    Key? key,
    required this.currentIndex,
    required this.dotCount,
    required this.onItemTap,
    required this.dotColor,
    required this.dotSelectedColor,
    required this.dotSize,
    required this.dotPadding,
    required this.selectOpacity,
    required this.unSelectedOpacity,
    required this.actualIndex,
  }) : super(key: key);

  Widget _renderItem(int index) {
    bool isSelected = currentIndex == index ? false : true;

    Color color = isSelected ? this.dotColor : this.dotSelectedColor;

    BoxShape boxShape = isSelected ? BoxShape.circle : BoxShape.rectangle;

    double padding = isSelected ? dotPadding : (dotPadding - (dotSize / 2));

    double opacity = isSelected ? unSelectedOpacity : selectOpacity;

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, dotPadding, padding, dotPadding),
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: currentIndex == index ? dotSize * 2 : dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              shape: boxShape,
              color: color,
              borderRadius:
                  currentIndex == index ? BorderRadius.circular(dotSize) : null,
            ),
          ),
        ),
      ),
      onTap: () {
        onItemTap(actualIndex + index - currentIndex);
      },
    );
  }

  ///計算indicator寬度
  double getWidth() {
    return dotSize * (dotCount + 1) + this.dotPadding * (dotCount + 5);
  }

  ///計算indicator高度
  double getHeight() {
    return dotSize + dotPadding * 2;
  }

  ///建立indicator陣列
  Widget _getItems() {
    return Container(
      child: ListView.builder(
        itemCount: dotCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _renderItem(index);
        },
      ),
      width: getWidth(),
      height: getHeight(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///背景
        Container(
          height: this.getHeight(),
          color: Color.fromRGBO(0, 0, 0, 0),
        ),

        ///indicator
        Container(
          child: _getItems(),
          alignment: Alignment.center,
        )
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:imageslider/imagesslider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: MyPage(),
      ),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var images = [
    //images paths list
    'assets/ocean-1.png',
    'assets/ocean-2.png',
    'assets/ocean-3.png',
    'assets/ocean-4.png',
    'assets/ocean-5.png'
  ];

  @override
  void initState() {
    // initialize zone
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //build image slider
    return Column(
      children: [
        Container(
          child: ImageSlider(
            imagePaths: images,
            height: 320,
            dotSelectedColor: Colors.white,
            selectOpacity: 1,
            unSelectedOpacity: 0.3,
            dotColor: Colors.black,
            dotSize: 8.0,
            dotPadding: 6.0,
            auto: true,
          ),
          height: 320,
        ),
      ],
    );
  }
}

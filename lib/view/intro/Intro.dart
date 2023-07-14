import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<String> _imageUrls = [
    'assets/images/guide/guide1.jpg',
    'assets/images/guide/guide2.jpg',
    'assets/images/guide/guide3.jpg',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _imageUrls.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                _imageUrls[index],
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Visibility(
              visible: _currentPage == _imageUrls.length - 1,
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  // 标记为已经不是第一次启动
                  await prefs.setBool('show_intro', false);
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '去体验',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

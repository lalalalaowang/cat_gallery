import 'package:cat_gallery/screen/breeds_screen.dart';
import 'package:cat_gallery/screen/cats_screen.dart';
import 'package:cat_gallery/screen/profile_screen.dart';
import 'package:cat_gallery/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeTab _currentTab = HomeTab.cats;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            _currentTab = HomeTab.values[value];
          });
        },
        children: const [
          CatsScreen(),
          BreedsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            _BottomTabButton(
                icon: "home.png",
                label: "首页",
                value: HomeTab.cats,
                groupValue: _currentTab,
                onTap: () {
                  _switchTab(HomeTab.cats);
                }),
            _BottomTabButton(
                icon: "classify.png",
                label: "品种",
                value: HomeTab.breeds,
                groupValue: _currentTab,
                onTap: () {
                  _switchTab(HomeTab.breeds);
                }),
            _BottomTabButton(
                icon: "mine.png",
                label: "我的",
                value: HomeTab.profile,
                groupValue: _currentTab,
                onTap: () {
                  _switchTab(HomeTab.profile);
                }),
          ],
        ),
      ),
    );
  }

  void _switchTab(HomeTab tab) {
    if (tab == _currentTab) return;

    _controller.animateToPage(tab.index,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }
}

enum HomeTab {
  cats,
  breeds,
  profile,
}

class _BottomTabButton extends StatelessWidget {
  final String icon;
  final String label;
  final HomeTab value;
  final HomeTab groupValue;
  final VoidCallback onTap;

  const _BottomTabButton({
    required this.icon,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final color = isSelected ? tabActiveColor : tabInactiveColor;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Image.asset(
              "images/$icon",
              color: color,
              height: 25,
              width: 25,
            ),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

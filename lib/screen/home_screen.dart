import 'package:cat_gallery/screen/breeds_screen.dart';
import 'package:cat_gallery/screen/cats_screen.dart';
import 'package:cat_gallery/screen/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          CatsScreen(),
          BreedsScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}

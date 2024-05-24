import 'package:flutter/material.dart';

class CatsScreen extends StatefulWidget {
  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("首页"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
